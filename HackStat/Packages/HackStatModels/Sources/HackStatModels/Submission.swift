//
//  Submission.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import Foundation

public struct Submission: Equatable, Sendable {
	public var date: Date
	public var submissionsCount: Int
	
	public init(date: Date, submissionsCount: Int) {
		self.date = date
		self.submissionsCount = submissionsCount
	}
	
	public static func == (lhs: Submission, rhs: Submission) -> Bool {
		lhs.date == rhs.date && lhs.submissionsCount == rhs.submissionsCount
	}
	
	#if DEBUG
	@MainActor public static let mockSubmissions: [Submission] = {
		var submissions = [Submission]()
		let calendar = Calendar.current
		let today = Date.now
		for i in 0..<365 {
			if let date = calendar.date(byAdding: .day, value: -i, to: today) {
				let randomSubmissions = Int.random(in: 0...10)
				if randomSubmissions > 0 {
					submissions.append(Submission(date: date, submissionsCount: randomSubmissions))
				}
			}
		}
		return submissions
	}()
	#endif
}
