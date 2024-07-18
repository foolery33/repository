//
//  CABasicAnimation+animations.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

extension CABasicAnimation {
	enum Keys {
		static let transformRotationZ = "transform.rotation.z"
		static let colors = "colors"
	}
	
	static func makeGradientAnimation(colors: [CGColor], duration: CGFloat, repeatCount: Float = .infinity) -> CABasicAnimation {
		let animation = CABasicAnimation(keyPath: Keys.colors)
		
		animation.fromValue = colors
		animation.toValue = Array(colors.reversed())
		animation.duration = duration
		animation.autoreverses = true
		animation.repeatCount = repeatCount

		return animation
	}

	static func makeRotationAnimation(angle: CGFloat, clockwise: Bool = true, duration: CGFloat, repeatCount: Float = .infinity) -> CABasicAnimation {
		let animation = CABasicAnimation(keyPath: Keys.transformRotationZ)
		let direction = clockwise ? 1.0 : -1.0
		animation.toValue = NSNumber(value: angle * direction)
		animation.duration = duration
		animation.isCumulative = true
		animation.repeatCount = repeatCount

		return animation
	}
}
