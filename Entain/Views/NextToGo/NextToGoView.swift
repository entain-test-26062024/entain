//
//  NextToGoView.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import SwiftUI

struct NextToGoView: View {
    // MARK: - Data
    @StateObject var viewModel: NextToGoViewModel = NextToGoViewModel()

    // MARK: - Lifecycle
    var body: some View {
        List {
            Section {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else {
                    ForEach(viewModel.races) { value in row(forRace: value) }
                }
            }
        }.task {
            await viewModel.onAppear()
        }.refreshable {
            await viewModel.refresh()
        }.overlay {
            if viewModel.isEmpty {
                emptyContent()
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    ForEach(RaceFilter.allCases) { filter in
                        Button {
                            didSelectFilter(filter)
                        } label: {
                            Label(filter.name, systemImage: filter.systemImageName)
                        }
                    }
                    Divider()
                    Button(role: .destructive) {
                        didClearFilters()
                    } label: {
                        Label("RESET_FILTERS", systemImage: "xmark.circle")
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
        }
    }

    private func didSelectFilter(_ filter: RaceFilter) {
        Task { await viewModel.didSelectFilter(filter) }
    }

    private func didClearFilters() {
        Task { await viewModel.didClearFilters() }
    }
}

// MARK: - View Builders
extension NextToGoView {
    @ViewBuilder func emptyContent() -> some View {
        if #available(iOS 17.0, *) {
            ContentUnavailableView {
                Label("NEXT_TO_GO_EMPTY_TITLE", systemImage: "magnifyingglass")
            } description: {
                Text("NEXT_TO_GO_EMPTY_BODY")
            } actions: {
                Button("RESET_FILTERS") {
                    didClearFilters()
                }
            }
        } else {
            VStack {
                Image(systemName: "magnifyingglass")
                Text("NEXT_TO_GO_EMPTY_TITLE")
                    .font(.headline)
                Text("NEXT_TO_GO_EMPTY_BODY")
                    .font(.subheadline)
                Button("RESET_FILTERS") {
                    didClearFilters()
                }
            }
        }
    }
    
    @ViewBuilder func row(forRace race: Race) -> some View {
        CountdownRow(title: race.name,
                     subtitle: race.description,
                     endDate: race.date,
                     color: race.color,
                     icon: race.systemImage,
                     alarmTriggerOffset: -60,
                     accessibilityStrings: TimeRepresentationAccessibilityStrings(futurePrefix: "Jumps in", pastPrefix: "Jumped", pastSuffix: "ago"),
                     onAlarm: {
                         Task { await viewModel.didReceiveAlarmFor(race) }
                     })
    }
}
