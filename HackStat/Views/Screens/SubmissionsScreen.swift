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
			ScrollView() {
				HStack {
					VStack(alignment: .leading) {
						Text("Submissions for: ")
							.bold()
						
						VStack(alignment: .leading) {
							PlatformUsernameLabel(title: settingsViewModel.githubUsername, image: Image(.github))
							PlatformUsernameLabel(title: settingsViewModel.gitlabUsername, image: Image(.gitlab))
							PlatformUsernameLabel(title: settingsViewModel.codewarsUsername, image: Image(.codewars))
							PlatformUsernameLabel(title: settingsViewModel.leetcodeUsername, image: Image(.leetcode))
						}
					}
					.padding([.leading, .top])
					
					Spacer()
				}
				
				SubmissionsGraph(submissions: submissionsViewModel.submissions)
					.padding(.horizontal)
					.transition(.scale)
			}
			.navigationTitle("HackStat")
			.task {
				await fetchSubmissions()
			}
		}
	}
	
	private func fetchSubmissions() async {
		if settingsViewModel.useSameUsername {
			await submissionsViewModel.fetchSubmissions(for: settingsViewModel.username)
		} else {
			let usernames = Usernames(
				github: settingsViewModel.githubUsername,
				gitlab: settingsViewModel.gitlabUsername,
				codewars: settingsViewModel.codewarsUsername,
				leetcode: settingsViewModel.leetcodeUsername
			)
			await submissionsViewModel.fetchSubmissions(for: usernames)
		}
	}
}

#Preview {
	SubmissionsScreen()
		.environment(SubmissionsViewModel.previewInstance)
		.environmentObject(SettingsViewModel())
	
}
