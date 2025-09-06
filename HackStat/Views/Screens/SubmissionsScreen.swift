//
//  SubmissionsScreen.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

struct SubmissionsScreen: View {
	@Environment(SubmissionsViewModel.self) private var submissionsViewModel
	
	@State private var username = "yatoenough"

	var body: some View {
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
			
			SubmissionsGraph(submissions: submissionsViewModel.submissions)
				.padding(.horizontal)
		}
		.navigationTitle("HackStat")
		.task {
			await fetchSubmissions()
		}
	}
	
	private func fetchSubmissions() async {
		await submissionsViewModel.fetchSubmissions(for: username)
	}
}

#Preview {
	NavigationStack {
		SubmissionsScreen()
			.environment(SubmissionsViewModel.previewInstance)
	}
}
