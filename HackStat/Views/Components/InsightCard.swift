//
//  InsightCard.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 28/10/2025.
//

import SwiftUI

struct InsightCard: View {
    let icon: String
    let title: String
    let description: String
    let gradient: [Color]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Text(icon)
                    .font(.system(size: 16))

                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }

            Text(description)
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.95))
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            LinearGradient(
                colors: gradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
    }
}

#Preview {
	InsightCard(icon: "🌍", title: "Demo", description: "Demo description", gradient: [.blue, .purple])
}
