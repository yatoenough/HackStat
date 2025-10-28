//
//  ActivitySection.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 27/10/2025.
//

import SwiftUI
import HackStatCore

struct ActivitySection: View {
    let submissionsViewModel: SubmissionsViewModel

    var dateRange: String {
        let calendar = Calendar.current
        let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return "\(formatter.string(from: oneYearAgo)) - \(formatter.string(from: Date()))"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("ACTIVITY")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                Text(dateRange)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
            }

            HStack(spacing: 8) {
                Text("Less")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)

                ForEach(0..<5) { level in
                    RoundedRectangle(cornerRadius: 3)
                        .fill(contributionColor(for: level))
                        .frame(width: 12, height: 12)
                }

                Text("More")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
            }

            SubmissionsGraph(submissions: submissionsViewModel.submissions)
				.skeleton(RoundedRectangle(cornerRadius: 12), isLoading: submissionsViewModel.isLoading)
        }
    }

    func contributionColor(for level: Int) -> Color {
        switch level {
        case 0: return .gray.opacity(0.1)
        case 1: return .blue.opacity(0.35)
        case 2: return .blue.opacity(0.55)
        case 3: return .blue.opacity(0.75)
        case 4: return .blue.opacity(1.0)
        default: return .gray.opacity(0.1)
        }
    }
}

#Preview {
    ActivitySection(submissionsViewModel: SubmissionsViewModel.previewInstance)
}
