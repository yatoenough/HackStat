//
//  SkeletonViewExt.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 28/10/2025.
//

import SwiftUI

extension View {
	func skeleton<S>(_ shape: S? = nil as Rectangle?, isLoading: Bool) -> some View where S: Shape {
		guard isLoading else { return AnyView(self) }
		
		let skeletonShape: AnyShape = if let shape {
			AnyShape(shape)
		} else {
			AnyShape(Rectangle())
		}
		
		return AnyView(
			opacity(0)
				.overlay(skeletonShape.fill(.gray.opacity(0.3)))
				.shimmering()
		)
	}
	
	func shimmering() -> some View {
		modifier(ShimmeringModifier())
	}
}
