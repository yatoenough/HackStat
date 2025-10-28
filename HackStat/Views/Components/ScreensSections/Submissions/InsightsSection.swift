//
//  InsightsSection.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 27/10/2025.
//

import SwiftUI
import HackStatCore
import HackStatModels

struct InsightsSection: View {
    let submissionsViewModel: SubmissionsViewModel

    var mostProductiveDay: String {
        var dayCounts: [Int: Int] = [:]

        for submission in submissionsViewModel.submissions {
            let weekday = Calendar.current.component(.weekday, from: submission.date)
            dayCounts[weekday, default: 0] += submission.submissionsCount
        }

        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"

        if let (weekday, _) = dayCounts.max(by: { $0.value < $1.value }) {
            let date = Calendar.current.date(from: DateComponents(weekday: weekday)) ?? Date()
            return dayFormatter.string(from: date)
        }

        return "Monday"
    }

    var avgSubmissionsPerDay: Int {
        guard !submissionsViewModel.submissions.isEmpty else { return 0 }
        let total = submissionsViewModel.submissions.reduce(0) { $0 + $1.submissionsCount }
        return total / submissionsViewModel.submissions.count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("INSIGHTS")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)

            if submissionsViewModel.submissions.isEmpty {
                Text("No submissions yet. Start tracking to see insights!")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .padding(.vertical, 20)
            } else {
                if submissionsViewModel.currentStreak > 0 {
                    InsightCard(
                        icon: "🔥",
                        title: "Current Streak",
                        description: "You're on a \(submissionsViewModel.currentStreak)-day streak! Keep it going to reach your personal best.",
                        gradient: [.blue.opacity(0.7), .purple.opacity(0.8)]
                    )
                } else {
                    InsightCard(
                        icon: "🔥",
                        title: "Current Streak",
                        description: "Start submitting today to build your first streak!",
                        gradient: [.blue.opacity(0.7), .purple.opacity(0.8)]
                    )
                }

                InsightCard(
                    icon: "📈",
                    title: "Most Productive",
                    description: "You're most active on \(mostProductiveDay)s with an average of \(avgSubmissionsPerDay) submissions per day.",
                    gradient: [.pink.opacity(0.8), .red.opacity(0.85)]
                )
            }
        }
		.skeleton(RoundedRectangle(cornerRadius: 12), isLoading: submissionsViewModel.isLoading)
    }
}

struct InsightCard: View {
    let icon: String
    let title: String
    let description: String
    let gradient: [Color]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Text(icon)
                    .font(.system(size: 16))

                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }

            Text(description)
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.95))
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            LinearGradient(
                colors: gradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
    }
}

#Preview {
    InsightsSection(submissionsViewModel: SubmissionsViewModel.previewInstance)
}
