//
//  StatsSection.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 27/10/2025.
//

import SwiftUI
import HackStatCore
import HackStatModels

struct StatsSection: View {
    let submissionsViewModel: SubmissionsViewModel

    var totalSubmissions: Int {
        submissionsViewModel.submissions.reduce(0) { $0 + $1.submissionsCount }
    }

    var thisMonthSubmissions: Int {
        let calendar = Calendar.current
        let now = Date()
        let monthAgo = calendar.date(byAdding: .month, value: -1, to: now) ?? now

        return submissionsViewModel.submissions
            .filter { $0.date >= monthAgo && $0.date <= now }
            .reduce(0) { $0 + $1.submissionsCount }
    }

    var body: some View {
        HStack(spacing: 12) {
            StatCard(number: totalSubmissions, label: "Total")
				.skeleton(RoundedRectangle(cornerRadius: 12), isLoading: submissionsViewModel.isLoading)
            StatCard(number: thisMonthSubmissions, label: "This Month")
				.skeleton(RoundedRectangle(cornerRadius: 12), isLoading: submissionsViewModel.isLoading)
            StatCard(number: submissionsViewModel.currentStreak, label: "Streak")
				.skeleton(RoundedRectangle(cornerRadius: 12), isLoading: submissionsViewModel.isLoading)
        }
    }
}

#Preview {
    StatsSection(submissionsViewModel: SubmissionsViewModel.previewInstance)
}
