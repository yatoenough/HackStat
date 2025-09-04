//
//  PreviewSubmissionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 04/09/2025.
//

import Foundation

struct PreviewSubmissionsProvider: SubmissionsProvider {
	func getSubmissions(for username: String) async -> Result<[Submission], any Error> {
		let submissions = [
			Submission(date: .now, submissionsCount: 3),
			Submission(date: .now, submissionsCount: 6),
			Submission(date: .now, submissionsCount: 2),
		]
		
		return .success(submissions)
	}
	
}
