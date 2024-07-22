//
//  CAKeyframeAnimation+animations.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 18.07.2024.
//

import UIKit

extension CAKeyframeAnimation {
	// MARK: - Public

	enum AnimationKeys: String {
		case transformRotationZ = "transform.rotation.z"
		case transformScale = "transform.scale"
		case positionY = "position.y"
		case positionX = "position.x"
		case opacity = "opacity"
	}

	static func makeAnimation(
		keyPath: AnimationKeys,
		duration: CGFloat,
		timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: .linear),
		isAdditive: Bool = true,
		clockwise: Bool = true,
		values: [Float],
		repeatCount: Float = .infinity,
		shouldRemove: Bool = false
	) -> CAKeyframeAnimation {
		let animation = CAKeyframeAnimation(keyPath: keyPath.rawValue)

		animation.duration = duration
		animation.timingFunction = timingFunction
		animation.isAdditive = isAdditive
		animation.repeatCount = repeatCount

		let direction: Float = clockwise ? 1 : -1
		animation.values = values.map { direction * $0 }

		if !shouldRemove {
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
		}

		return animation
	}

	func updated(duration: CGFloat? = nil,
				 timingFunction: CAMediaTimingFunction? = nil,
				 isAdditive: Bool? = nil,
				 clockwise: Bool? = nil,
				 values: [Float]? = nil,
				 repeatCount: Float? = nil,
				 shouldRemove: Bool? = nil) -> CAKeyframeAnimation {
		guard let copyAnimation = self.copy() as? CAKeyframeAnimation else { return .init() }
		if let duration {
			copyAnimation.duration = duration
		}
		if let timingFunction {
			copyAnimation.timingFunction = timingFunction
		}
		if let values {
			copyAnimation.values = values
		}
		if let isAdditive {
			copyAnimation.isAdditive = isAdditive
		}
		if let clockwise {
			var currentValues: [Float] = []
			if let values {
				currentValues = values
			} else {
				if let safeValues = self.values as? [Float] {
					currentValues = safeValues
				}
			}
			let direction: Float = clockwise ? 1.0 : -1.0
			copyAnimation.values = currentValues.map { direction * $0 }
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
