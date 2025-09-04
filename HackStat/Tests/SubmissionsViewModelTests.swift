//
//  SubmissionsViewModelTests.swift
//  HackStatTests
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import Testing
import Foundation

@testable import HackStat

@MainActor
@Suite("SubmissionsViewModel Unit Tests")
struct SubmissionsViewModelTests {

    @Test
	func `Success fetching submissions`() async {
		let instance = SubmissionsViewModel(providers: [MockSubmissionsProvider()])
		let expected = Submission.mockSubmissions
		
		await instance.fetchSubmissions(for: "username")
		
		#expect(instance.submissions == expected)
    }
	
	@Test
	func `Failure fetching submissions`() async {
		let instance = SubmissionsViewModel(providers: [MockSubmissionsProvider(returnsError: true)])
		let expected = [Submission]()
		
		await instance.fetchSubmissions(for: "username")
		
		#expect(instance.submissions == expected)
	}

}
