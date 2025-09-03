//
//  SubmissionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

protocol SubmissionsProvider: Sendable {
	func getSubmissions(for username: String) async -> Result<[Submission], Error>
}
