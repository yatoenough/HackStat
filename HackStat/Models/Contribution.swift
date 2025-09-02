//
//  Contribution.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 02/09/2025.
//

import Foundation

struct Contribution: Identifiable, Codable {
	var id: UUID
	var date: Date
	var contributionsCount: Int
}
