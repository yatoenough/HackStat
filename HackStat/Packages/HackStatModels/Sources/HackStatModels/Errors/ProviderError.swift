//
//  ProviderError.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 07/09/2025.
//

public struct ProviderError: Error {
	let platform: PlatformType
	let error: Error
}
