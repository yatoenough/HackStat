//
//  SubmissionsScreen.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

struct SubmissionsScreen: View {
	@Environment(SubmissionsViewModel.self) private var submissionsViewModel
	
	@AppStorage("username") private var username = "yatoenough"

	var body: some View {
		NavigationStack {
			ScrollView {
				VStack(alignment: .leading) {
					Text("Submissions for: ")
						.bold()
					
					TextField("Username", text: $username)
						.onSubmit {
							Task {
								await fetchSubmissions()
							}
						}
				}
				.padding([.leading, .top])
				
				if submissionsViewModel.submissions.isEmpty {
					ProgressView()
						.progressViewStyle(.circular)
						.transition(.scale)
				} else {
					SubmissionsGraph(submissions: submissionsViewModel.submissions)
						.padding(.horizontal)
						.transition(.scale)
				}
			}
			.navigationTitle("HackStat")
			.task {
				await fetchSubmissions()
			}
		}
	}
	
	private func fetchSubmissions() async {
		await submissionsViewModel.fetchSubmissions(for: username)
	}
}

#Preview {
	SubmissionsScreen()
		.environment(SubmissionsViewModel.previewInstance)
	
}
