//
//  SubmissionsGraph.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//

import SwiftUI
import HackStatModels
import HackStatCore

public struct SubmissionsGraph: View {
    let submissions: [Submission]

    @Environment(SettingsViewModel.self) private var settingsViewModel

    public init(submissions: [Submission]) {
        self.submissions = submissions
    }

    private let weeksToShow = 52
    private let daysInWeek = 7
    private let cellSize: CGFloat = 25
    private let cellSpacing: CGFloat = 4

    private var calendar: Calendar {
        var calendar = Calendar.current
        calendar.firstWeekday = settingsViewModel.firstWeekday
        return calendar
    }

    private var submissionsByDate: [Date: Int] {
        let grouped = Dictionary(grouping: submissions, by: { calendar.startOfDay(for: $0.date) })
        return grouped.mapValues { $0.reduce(0) { $0 + $1.submissionsCount } }
    }

    private var dateCells: [Date] {
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let daysToAlignToStartOfWeek = (weekday - calendar.firstWeekday + daysInWeek) % daysInWeek
        let startDateOfCurrentWeek = calendar.date(byAdding: .day, value: -daysToAlignToStartOfWeek, to: today)!

        let startDate = calendar.date(byAdding: .weekOfYear, value: -(weeksToShow - 1), to: startDateOfCurrentWeek)!

        var dates = [Date]()
        for i in 0..<(weeksToShow * daysInWeek) {
            if let date = calendar.date(byAdding: .day, value: i, to: startDate) {
                dates.append(date)
            }
        }
        return dates
    }

    public var body: some View {
        let dates = dateCells
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
        let endOfToday = calendar.startOfDay(for: tomorrow)

        VStack(alignment: .leading, spacing: 5) {
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: cellSpacing) {
                        ForEach(0..<weeksToShow, id: \.self) { week in
                            VStack(spacing: cellSpacing) {
                                ForEach(0..<daysInWeek, id: \.self) { day in
                                    let index = week * daysInWeek + day
                                    if index < dates.count {
                                        let date = dates[index]
                                        let count = submissionsByDate[calendar.startOfDay(for: date)] ?? 0

                                        Rectangle()
                                            .fill(date > endOfToday ? Color.clear : colorFor(count: count))
                                            .frame(width: cellSize, height: cellSize)
                                            .cornerRadius(3)
                                    }
                                }
                            }
                            .id(week)
                        }
                    }
                }
				.scrollIndicators(.hidden)
                .onAppear {
                    proxy.scrollTo(weeksToShow - 1, anchor: .trailing)
                }
            }
        }
    }

    private func colorFor(count: Int) -> Color {
        guard count > 0 else {
            return Color(.systemGray5)
        }

        let maxCount = submissions.max(by: { $0.submissionsCount < $1.submissionsCount })?.submissionsCount ?? 0
        guard maxCount > 0 else { return Color(.systemGray5) }

        let percentage = Double(count) / Double(maxCount)

        switch percentage {
        case 0..<0.1:
            return .accentColor.opacity(0.35)
        case 0.1..<0.3:
            return .accentColor.opacity(0.55)
        case 0.3..<0.5:
            return .accentColor.opacity(0.65)
        case 0.5..<0.75:
            return .accentColor.opacity(0.9)
        default:
            return .accentColor
        }
    }
}

#Preview {
    SubmissionsGraph(submissions: Submission.mockSubmissions)
        .environment(SettingsViewModel())
}
