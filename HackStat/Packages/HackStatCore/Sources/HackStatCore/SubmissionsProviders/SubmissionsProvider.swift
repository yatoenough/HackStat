//
//  SubmissionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import HackStatModels

public protocol SubmissionsProvider: Sendable {
	var platformType: PlatformType { get }
	func getSubmissions(for username: String) async -> Result<[Submission], Error>
}
