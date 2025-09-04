//
//  Submission.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import Foundation

struct Submission: Identifiable, Equatable {
	let id = UUID()
	var date: Date
	var submissionsCount: Int
	
	static func == (lhs: Submission, rhs: Submission) -> Bool {
		lhs.date == rhs.date && lhs.submissionsCount == rhs.submissionsCount
	}
	
	#if DEBUG
	static let mockSubmissions = {
		let date = Date()
		
		let submissions = [
			Submission(date: date, submissionsCount: 3),
			Submission(date: date, submissionsCount: 6),
			Submission(date: date, submissionsCount: 2),
		]
		
		return submissions
	}()
	#endif
}
