//
//  PlatformStatus.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 07/09/2025.
//

public enum PlatformStatus {
	case idle
	case loading  
	case success
	case failed
	case skipped
}

public struct PlatformLoadingState {
	private(set) public var github: PlatformStatus = .idle
	private(set) public var gitlab: PlatformStatus = .idle
	private(set) public var codewars: PlatformStatus = .idle
	private(set) public var leetcode: PlatformStatus = .idle
	
	public init() {}
	
	public mutating func setStatus(for platform: PlatformType, status: PlatformStatus) {
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
	
	public func getStatus(for platform: PlatformType) -> PlatformStatus {
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
