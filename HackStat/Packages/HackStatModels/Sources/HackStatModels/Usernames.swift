//
//  Usernames.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//

public struct Usernames: Equatable {
	public let github: String
	public let gitlab: String
	public let codewars: String
	public let leetcode: String
	
	public init(github: String, gitlab: String, codewars: String, leetcode: String) {
		self.github = github
		self.gitlab = gitlab
		self.codewars = codewars
		self.leetcode = leetcode
	}
}
