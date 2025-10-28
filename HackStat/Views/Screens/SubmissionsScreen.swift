//
//  SubmissionsScreen.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 27/10/2025.
//

import SwiftUI
import HackStatCore
import HackStatModels

struct SubmissionsScreen: View {
	@Environment(SubmissionsViewModel.self) private var submissionsViewModel
	@Environment(SettingsViewModel.self) private var settingsViewModel
	
	let onRefresh: @Sendable () async -> Void
	
	init(onRefresh: @Sendable @escaping () async -> Void = {}) {
		self.onRefresh = onRefresh
	}
	
	var displayUsername: String{
		if settingsViewModel.useSameUsername {
			settingsViewModel.universalUsername.isEmpty ? "No Username" : settingsViewModel.universalUsername
		} else {
			"Multiple usernames"
		}
	}

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
					VStack(alignment: .leading, spacing: 8) {
						GradientText(text: "HackStat")

						HStack(spacing: 8) {
							Image(systemName: "person.circle.fill")
								.font(.system(size: 20))
								.foregroundColor(.gray)

							

							Text(displayUsername)
								.font(.system(size: 18))
								.foregroundColor(.gray)
						}
					}
					.padding(.horizontal)
					.padding(.top, 10)

                    StatsSection(submissionsViewModel: submissionsViewModel)
                        .padding(.horizontal)
                        .padding(.top, 20)

                    PlatformsSection(submissionsViewModel: submissionsViewModel)
                        .padding(.horizontal)
                        .padding(.top, 24)

                    ActivitySection(submissionsViewModel: submissionsViewModel)
                        .padding(.horizontal)
                        .padding(.top, 24)

                    InsightsSection(submissionsViewModel: submissionsViewModel)
                        .padding(.horizontal)
                        .padding(.top, 24)
                        .padding(.bottom, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
			.refreshable(action: onRefresh)
        }
    }
}

#Preview {
	SubmissionsScreen()
		.environment(SubmissionsViewModel.previewInstance)
		.environment(SettingsViewModel())
}
