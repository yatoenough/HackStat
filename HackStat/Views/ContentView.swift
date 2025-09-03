//
//  ContentView.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import SwiftUI

struct ContentView: View {
	@State private var submissionsViewModel = SubmissionsViewModel()
	
    var body: some View {
		if submissionsViewModel.submissions.isEmpty {
			ProgressView()
				.progressViewStyle(.circular)
		} else {
			List(submissionsViewModel.submissions, id: \.id) { submission in
				Text("\(submission.date) - \(submission.submissionsCount)")
			}
		}
    }
}

#Preview {
    ContentView()
}
