//
//  PlatformStatus.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 07/09/2025.
//

enum PlatformStatus {
	case idle
	case loading  
	case success
	case failed
	case skipped
}

struct PlatformLoadingState {
	private(set) var github: PlatformStatus = .idle
	private(set) var gitlab: PlatformStatus = .idle
	private(set) var codewars: PlatformStatus = .idle
	private(set) var leetcode: PlatformStatus = .idle
	
	mutating func setStatus(for platform: PlatformType, status: PlatformStatus) {
		switch platform {
		case .github:
			github = status
		case .gitlab:
			gitlab = status
		case .codewars:
			codewars = status
		case .leetcode:
			leetcode = status
		}
	}
	
	func getStatus(for platform: PlatformType) -> PlatformStatus {
		switch platform {
		case .github:
			return github
		case .gitlab:
			return gitlab
		case .codewars:
			return codewars
		case .leetcode:
			return leetcode
		}
	}
}
