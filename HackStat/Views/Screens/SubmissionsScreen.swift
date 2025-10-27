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
    @State private var isRefreshing = false
	
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: refreshData) {
                        if isRefreshing {
                            ProgressView()
                                .tint(.purple)
                        } else {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.purple)
                        }
                    }
                    .disabled(isRefreshing)
                }
            }
        }
        .task {
            await loadInitialData()
        }
    }

    private func loadInitialData() async {
        let usernames = settingsViewModel.resolveUsernames()
        await submissionsViewModel.fetchSubmissions(for: usernames)
    }

    private func refreshData() {
        Task {
            isRefreshing = true
            await loadInitialData()
            isRefreshing = false
        }
    }
}

#Preview {
	SubmissionsScreen()
		.environment(SubmissionsViewModel.previewInstance)
		.environment(SettingsViewModel())
}
