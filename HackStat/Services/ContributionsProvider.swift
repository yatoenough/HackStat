//
//  ContributionsProvider.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

protocol ContributionsProvider: Sendable {
	func getContributions(for username: String) async -> [Contribution]
}
