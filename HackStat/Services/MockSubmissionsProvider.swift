//
//  MockSubmissionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 04/09/2025.
//

import Foundation
import HackStatModels

struct MockSubmissionsProvider: SubmissionsProvider {
	let platformType: PlatformType = .github
	private let returnsError: Bool
	
	init(returnsError: Bool = false) {
		self.returnsError = returnsError
	}
	
	func getSubmissions(for username: String) async -> Result<[Submission], any Error> {
		if returnsError {
			struct MockError: Error {}
			return .failure(MockError())
		}
		return .success(Submission.mockSubmissions)
	}
	
}
