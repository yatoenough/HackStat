//
//  MockSubmissionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 04/09/2025.
//

import Foundation
import HackStatModels

public struct MockSubmissionsProvider: SubmissionsProvider {
	public let platformType: PlatformType = .github
	
	private let returnsError: Bool
	
	public init(returnsError: Bool = false) {
		self.returnsError = returnsError
	}
	
	public func getSubmissions(for username: String) async -> Result<[Submission], any Error> {
		if returnsError {
			struct MockError: Error {}
			return .failure(MockError())
		}
		return await .success(Submission.mockSubmissions)
	}
	
}
