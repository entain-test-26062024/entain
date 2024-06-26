//
//  CountdownRow.swift
//  Entain
//
//  Created by BS Entain on 25/6/2024.
//

import SwiftUI

struct CountdownRow: View {
    // MARK: - Data
    private var title: String
    private var subtitle: String
    private var endDate: Date
    private var alarmTriggerOffset: Int = .zero
    private var color: Color
    private var icon: String?
    private var accessibilityStrings: TimeRepresentationAccessibilityStrings?
    let onAlarm: ActionBlock?

    // MARK: - Internal Data
    @State private var timeRemaining: Int = .zero
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // MARK: - Lifecycle
    init(title: String, subtitle: String, endDate: Date, color: Color, icon: String? = nil, alarmTriggerOffset: Int = .zero, accessibilityStrings: TimeRepresentationAccessibilityStrings? = nil, onAlarm: ActionBlock?) {
        self.title = title
        self.subtitle = subtitle
        self.endDate = endDate
        self.color = color
        self.icon = icon
        self.alarmTriggerOffset = alarmTriggerOffset
        self.accessibilityStrings = accessibilityStrings
        self.timeRemaining = Date.now.unitsOf(.second, since: endDate)
        self.onAlarm = onAlarm
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    if let icon = icon {
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(color)
                    }
                    Text(title)
                        .font(.system(.headline))
                        .foregroundStyle(color)
                }
                Text(LocalizedStringKey(subtitle))
                    .font(.system(.subheadline))
            }
            Spacer()
            Text("\(timeRemaining.timeRepresentation.description)")
                .font(.system(.body))
                .foregroundStyle(.gray)
        }.onReceive(timer) { time in
            timeRemaining = Date.now.unitsOf(.second, since: endDate)
            guard timeRemaining <= alarmTriggerOffset else { return }
            timer.upstream.connect().cancel()
            onAlarm?()
        }.accessibilityElement(children: .ignore)
            .accessibilityAddTraits([.isStaticText])
            .accessibilityLabel(accessibilityLabel)
            .accessibilityValue(accessibilityValue)
    }

    var accessibilityLabel: String {
        return "\(title), \(subtitle)".replacingOccurrences(of: ":", with: "")
    }

    var accessibilityValue: String {
        var value: String = "\(timeRemaining.timeRepresentation.accessibilityDescription)"
        if timeRemaining >= 0 {
            if let prefix = accessibilityStrings?.futurePrefix { value.prepend("\(prefix) ") }
            if let suffix = accessibilityStrings?.futureSuffix { value.prepend(" \(suffix)") }
        } else {
            if let prefix = accessibilityStrings?.pastPrefix { value.prepend("\(prefix) ") }
            if let suffix = accessibilityStrings?.pastSuffix { value.prepend(" \(suffix)") }
        }
        return value
    }
}

