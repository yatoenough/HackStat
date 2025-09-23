//
//  SubmissionsScreen.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI
import HackStatModels
import HackStatCore

struct SubmissionsScreen: View {
	@Environment(SubmissionsViewModel.self) private var submissionsViewModel
	@Environment(SettingsViewModel.self) private var settingsViewModel

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
								image: Image(.github),
								status: submissionsViewModel.platformStates.github
							)
							PlatformUsernameLabel(
								title: settingsViewModel.gitlabUsername,
								image: Image(.gitlab),
								status: submissionsViewModel.platformStates.gitlab
							)
							PlatformUsernameLabel(
								title: settingsViewModel.codewarsUsername,
								image: Image(.codewars),
								status: submissionsViewModel.platformStates.codewars
							)
							PlatformUsernameLabel(
								title: settingsViewModel.leetcodeUsername,
								image: Image(.leetcode),
								status: submissionsViewModel.platformStates.leetcode
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
						.transition(.opacity.combined(with: .scale(scale: 0.8)))
						.animation(.easeInOut(duration: 0.3), value: submissionsViewModel.loadingState)
				case .loaded:
					SubmissionsGraph(
						submissions: submissionsViewModel.submissions
					)
					.padding(.horizontal)
					.transition(.asymmetric(
						insertion: .opacity.combined(with: .move(edge: .bottom)),
						removal: .opacity.combined(with: .scale(scale: 0.9))
					))
					.animation(.spring(response: 0.6, dampingFraction: 0.8), value: submissionsViewModel.loadingState)
				case .error(let message):
					VStack(spacing: 16) {
						Image(systemName: "exclamationmark.triangle")
							.font(.largeTitle)
							.foregroundColor(.orange)
							.scaleEffect(1.0)
							.animation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.1), value: submissionsViewModel.loadingState)
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
						.scaleEffect(1.0)
						.animation(.spring(response: 0.4, dampingFraction: 0.7).delay(0.3), value: submissionsViewModel.loadingState)
					}
					.padding()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.transition(.asymmetric(
						insertion: .opacity.combined(with: .move(edge: .top)),
						removal: .opacity.combined(with: .scale(scale: 0.8))
					))
					.animation(.easeInOut(duration: 0.4), value: submissionsViewModel.loadingState)
				}
			}
			.animation(.easeInOut(duration: 0.25), value: submissionsViewModel.loadingState)
			.navigationTitle("HackStat")
			.onChange(of: settingsViewModel.resolveUsernames()) { _, _ in
				Task { await fetchSubmissions() }
			}
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button {
						Task {
							await fetchSubmissions()
						}
					} label: {
						Image(systemName: "arrow.trianglehead.clockwise")
					}
				}
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
		.environment(SettingsViewModel())
}
