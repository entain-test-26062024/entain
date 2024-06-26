//
//  NextToGoViewModel.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Combine
import SwiftUI

@MainActor class NextToGoViewModel: ObservableObject {
    // MARK: - Data
    @Published var isLoading: Bool = false
    @Published var isEmpty: Bool = false
    @Published var races: [Race] = []
    var selectedFilter: RaceFilter?

    // MARK: - Repository
    var repository: NextToGoRepository

    // MARK: - Lifecycle
    init(repository: NextToGoRepository = NextToGoRepository()) {
        self.repository = repository
    }

    func onAppear() async {
        defer { isLoading = false }
        isLoading = true
        await refresh()
    }

    func refresh() async {
        await fetchRaces()
    }

    func fetchRaces() async {
        defer { isEmpty = races.isEmpty }
        guard let value = await repository.getRaces(count: 10) else { return }
        var values = value.data?.raceSummaries?.map({ $0.value }).filter({ Date(unixTime: $0.advertisedStart.seconds).unitsOf(.minute, since: .now) < 1 }) ?? []
        guard values.isNotEmpty else {
            races.removeAll()
            return
        }
        values.sort(by: { Date(unixTime: $0.advertisedStart.seconds) <= Date(unixTime: $1.advertisedStart.seconds) })
        if let selectedFilter = selectedFilter { values.removeAll(where: { $0.categoryID != selectedFilter.id }) }
        races = values.prefix(5).map({ race in
            let filter = RaceFilter.allCases.first(where: { $0.id == race.categoryID })
            let value = Race(id: race.raceID,
                             name: race.meetingName,
                             description: "Race number: \(race.raceNumber)",
                             date: Date(unixTime: race.advertisedStart.seconds),
                             color: filter?.color ?? .accentColor,
                             systemImage: filter?.systemImageName)
            return value
        })
    }

    func didSelectFilter(_ filter: RaceFilter) async {
        selectedFilter = filter
        await fetchRaces()
    }

    func didClearFilters() async {
        selectedFilter = nil
        await fetchRaces()
    }

    func didReceiveAlarmFor(_ race: Race) async {
        races.removeAll(where: { $0 == race })
        await refresh()
    }
}
