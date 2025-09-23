//
//  SubmissionsViewModelTests.swift
//  HackStatTests
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import Testing
import Foundation
import HackStatModels

@testable import HackStatCore

@MainActor
@Suite("SubmissionsViewModel Unit Tests")
struct SubmissionsViewModelTests {
	
	private let usernames = Usernames(github: "", gitlab: "", codewars: "", leetcode: "")

    @Test
	func `Success fetching submissions`() async {
		let instance = SubmissionsViewModel(providers: [MockSubmissionsProvider()])
		var expected = Submission.mockSubmissions

		expected.sort { $0.date > $1.date }
		
		await instance.fetchSubmissions(for: usernames)
		
		#expect(instance.submissions == expected)
    }
	
	@Test
	func `Failure fetching submissions`() async {
		let instance = SubmissionsViewModel(providers: [MockSubmissionsProvider(returnsError: true)])
		let expected = [Submission]()
		
		await instance.fetchSubmissions(for: usernames)
		
		#expect(instance.submissions == expected)
	}

}
