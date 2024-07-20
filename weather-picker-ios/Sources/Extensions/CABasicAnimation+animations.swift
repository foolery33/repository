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
		autoreverses: Bool = false,
		isCumulative: Bool = true,
		repeatCount: Float = .infinity,
		shouldRemove: Bool = false
	) -> CABasicAnimation {
		let animation = CABasicAnimation(keyPath: keyPath.rawValue)

		animation.duration = duration
		animation.timingFunction = timingFunction
		animation.fromValue = fromValue
		animation.toValue = toValue
		animation.autoreverses = autoreverses
		animation.isCumulative = isCumulative
		animation.repeatCount = repeatCount

		if !shouldRemove {
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
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
}
