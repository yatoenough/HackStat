//
//  LoadingState.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 07/09/2025.
//

public enum LoadingState: Equatable {
	case idle
	case loading
	case loaded
	case error(String)
}
