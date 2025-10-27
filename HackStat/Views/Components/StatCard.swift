//
//  StatCard.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 27/10/2025.
//

import SwiftUI

struct StatCard: View {
    let number: Int
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text("\(number)")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.blue.opacity(0.7))

            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.gray)
                .textCase(.uppercase)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            LinearGradient(
                colors: [.blue.opacity(0.08), .purple.opacity(0.15)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
    }
}

#Preview {
	StatCard(number: 10, label: "Demo")
}
