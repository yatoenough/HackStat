//
//  ContentView.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

struct ContentView: View {
	@Environment(SubmissionsViewModel.self) private var submissionsViewModel

	var body: some View {
		List(submissionsViewModel.submissions, id: \.id) { submission in
			Text("\(submission.date) - \(submission.submissionsCount)")
		}
		.task {
			await submissionsViewModel.fetchSubmissions(for: "yatoenough")
		}
	}
}

#Preview {
	ContentView()
}
