//
//  SubmissionsScreen.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

struct SubmissionsScreen: View {
	@Environment(SubmissionsViewModel.self) private var submissionsViewModel
	
	@AppStorage(Strings.useSameUsernameKey) private var useSameUsername = false
	@AppStorage(Strings.universalUsernameKey) private var username = ""
	
	@AppStorage(Strings.githubUsernameKey) private var githubUsername = ""
	@AppStorage(Strings.gitlabUsernameKey) private var gitlabUsername = ""
	@AppStorage(Strings.codewarsUsernameKey) private var codewarsUsername = ""
	@AppStorage(Strings.leetcodeUsernameKey) private var leetcodeUsername = ""

	var body: some View {
		NavigationStack {
			ScrollView() {
				HStack {
					VStack(alignment: .leading) {
						Text("Submissions for: ")
							.bold()
						
						VStack(alignment: .leading) {
							PlatformUsernameLabel(title: githubUsername, image: Image(.github))
							PlatformUsernameLabel(title: gitlabUsername, image: Image(.gitlab))
							PlatformUsernameLabel(title: codewarsUsername, image: Image(.codewars))
							PlatformUsernameLabel(title: leetcodeUsername, image: Image(.leetcode))
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
		if useSameUsername {
			await submissionsViewModel.fetchSubmissions(for: username)
		} else {
			let usernames = Usernames(
				github: githubUsername,
				gitlab: gitlabUsername,
				codewars: codewarsUsername,
				leetcode: leetcodeUsername
			)
			await submissionsViewModel.fetchSubmissions(for: usernames)
		}
	}
}

#Preview {
	SubmissionsScreen()
		.environment(SubmissionsViewModel.previewInstance)
	
}
