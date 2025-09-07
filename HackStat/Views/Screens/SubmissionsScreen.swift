//
//  SubmissionsScreen.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

struct SubmissionsScreen: View {
	@Environment(SubmissionsViewModel.self) private var submissionsViewModel
	@EnvironmentObject private var settingsViewModel: SettingsViewModel

	var body: some View {
		NavigationStack {
			ScrollView {
				HStack {
					VStack(alignment: .leading) {
						Text("Submissions for: ")
							.bold()

						VStack(alignment: .leading) {
							PlatformUsernameLabel(
								title: settingsViewModel.githubUsername,
								image: Image(.github)
							)
							PlatformUsernameLabel(
								title: settingsViewModel.gitlabUsername,
								image: Image(.gitlab)
							)
							PlatformUsernameLabel(
								title: settingsViewModel.codewarsUsername,
								image: Image(.codewars)
							)
							PlatformUsernameLabel(
								title: settingsViewModel.leetcodeUsername,
								image: Image(.leetcode)
							)
						}
					}
					.padding([.leading, .top])

					Spacer()
				}

				switch submissionsViewModel.loadingState {
				case .idle:
					EmptyView()
				case .loading:
					ProgressView("Loading submissions...")
						.frame(maxWidth: .infinity, maxHeight: .infinity)
				case .loaded:
					SubmissionsGraph(
						submissions: submissionsViewModel.submissions
					)
					.padding(.horizontal)
					.transition(.scale)
				case .error(let message):
					VStack(spacing: 16) {
						Image(systemName: "exclamationmark.triangle")
							.font(.largeTitle)
							.foregroundColor(.orange)
						Text("Error Loading Data")
							.font(.headline)
						Text(message)
							.foregroundColor(.secondary)
							.multilineTextAlignment(.center)
						Button("Retry") {
							Task {
								await fetchSubmissions()
							}
						}
						.buttonStyle(.bordered)
					}
					.padding()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
				}
			}
			.navigationTitle("HackStat")
			.task {
				await fetchSubmissions()
			}
		}
	}

	private func fetchSubmissions() async {
		let usernames = settingsViewModel.resolveUsernames()
		await submissionsViewModel.fetchSubmissions(for: usernames)
	}
}

#Preview {
	SubmissionsScreen()
		.environment(SubmissionsViewModel.previewInstance)
		.environmentObject(SettingsViewModel())
}
