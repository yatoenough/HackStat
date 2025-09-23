//
//  PlatformStatusIndicator.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 07/09/2025.
//

import SwiftUI
import HackStatModels

struct PlatformStatusIndicator: View {
	let status: PlatformStatus
	
	var body: some View {
		Circle()
			.fill(statusColor)
			.frame(width: 8, height: 8)
			.animation(.easeInOut(duration: 0.3), value: status)
	}
	
	private var statusColor: Color {
		switch status {
		case .idle, .skipped:
			return .gray
		case .loading:
			return .blue
		case .success:
			return .green
		case .failed:
			return .red
		}
	}
}

#Preview {
	HStack(spacing: 16) {
		VStack(spacing: 8) {
			Text("Loading")
			PlatformStatusIndicator(status: .loading)
		}
		
		VStack(spacing: 8) {
			Text("Success")
			PlatformStatusIndicator(status: .success)
		}
		
		VStack(spacing: 8) {
			Text("Failed")
			PlatformStatusIndicator(status: .failed)
		}
		
		VStack(spacing: 8) {
			Text("Skipped")
			PlatformStatusIndicator(status: .skipped)
		}
	}
	.padding()
}
