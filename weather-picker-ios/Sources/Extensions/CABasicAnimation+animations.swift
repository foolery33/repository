//
//  CABasicAnimation+animations.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

extension CABasicAnimation {
	enum BasicAnimationKeys: String {
		case transformRotationZ = "transform.rotation.z"
		case colors = "colors"
		case positionY = "position.y"
		case path = "path"
		case opacity = "opacity"
	}

	static func makeAnimation(
		keyPath: BasicAnimationKeys,
		duration: CGFloat,
		fromValue: Any? = nil,
		toValue: Any? = nil,
		timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: .linear),
		autoreverses: Bool = true,
		isCumulative: Bool = true,
		repeatCount: Float = .infinity,
		shouldRemove: Bool = true
	) -> CABasicAnimation {
		let animation = CABasicAnimation(keyPath: keyPath.rawValue)

		animation.duration = duration
		animation.timingFunction = timingFunction
		animation.fromValue = fromValue
		animation.toValue = toValue
		animation.autoreverses = true
		animation.repeatCount = repeatCount

		if !shouldRemove {
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
			animation.autoreverses = false
		}

		return animation
	}

	func updated(
		duration: CGFloat? = nil,
		fromValue: Any? = nil,
		toValue: Any? = nil,
		timingFunction: CAMediaTimingFunction? = nil,
		autoreverses: Bool? = nil,
		isCumulative: Bool? = nil,
		repeatCount: Float? = nil,
		shouldRemove: Bool? = nil
	) -> CABasicAnimation {
		guard let copyAnimation = self.copy() as? CABasicAnimation else { return .init() }
		if let duration {
			copyAnimation.duration = duration
		}
		if let timingFunction {
			copyAnimation.timingFunction = timingFunction
		}
		if let fromValue {
			copyAnimation.fromValue = fromValue
		}
		if let toValue {
			copyAnimation.toValue = toValue
		}
		if let autoreverses {
			copyAnimation.autoreverses = autoreverses
		}
		if let isCumulative {
			copyAnimation.isCumulative = isCumulative
		}
		if let repeatCount {
			copyAnimation.repeatCount = repeatCount
		}
		if let shouldRemove {
			if shouldRemove {
				copyAnimation.isRemovedOnCompletion = true
				copyAnimation.fillMode = .removed
			} else {
				copyAnimation.isRemovedOnCompletion = false
				copyAnimation.fillMode = .forwards
			}
		}
		return copyAnimation
	}

	static func makeGradientAnimation(colors: [CGColor], duration: CGFloat, repeatCount: Float = .infinity) -> CABasicAnimation {
		let animation = CABasicAnimation(keyPath: BasicAnimationKeys.colors.rawValue)

		animation.fromValue = colors
		animation.toValue = Array(colors.reversed())
		animation.duration = duration
		animation.autoreverses = true
		animation.repeatCount = repeatCount

		return animation
	}

	static func makeRotationAnimation(angle: CGFloat, clockwise: Bool = true, duration: CGFloat, repeatCount: Float = .infinity) -> CABasicAnimation {
		let animation = CABasicAnimation(keyPath: BasicAnimationKeys.transformRotationZ.rawValue)
		let direction = clockwise ? 1.0 : -1.0
		animation.toValue = NSNumber(value: angle * direction)
		animation.duration = duration
		animation.isCumulative = true
		animation.repeatCount = repeatCount

		return animation
	}
}
