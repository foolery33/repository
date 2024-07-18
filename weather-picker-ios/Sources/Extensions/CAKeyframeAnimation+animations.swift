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
	}

	static func makeAnimation(
		keyPath: AnimationKeys,
		duration: CGFloat,
		timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: .linear),
		clockwise: Bool = true,
		values: [Float],
		repeatCount: Float = .infinity,
		shouldRemove: Bool = true
	) -> CAKeyframeAnimation {
		let animation = CAKeyframeAnimation(keyPath: keyPath.rawValue)
		animation.duration = duration
		animation.timingFunction = timingFunction
		animation.isAdditive = true
		animation.repeatCount = repeatCount

		let direction: Float = clockwise ? 1 : -1
		animation.values = values.map { direction * $0 }

		if !shouldRemove {
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
		}

		return animation
	}

	static func makeStarShiningAnimation(duration: CGFloat, clockwise: Bool = true) -> CAAnimationGroup {
		let animationGroup = CAAnimationGroup()
		animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		animationGroup.duration = duration

		let rotationAnimation = CAKeyframeAnimation(keyPath: AnimationKeys.transformRotationZ.rawValue)

		let direction: Float = clockwise ? 1.0 : -1.0
		rotationAnimation.values = [0, direction * Float.pi / 6, 0]
		rotationAnimation.isAdditive = true

		let scaleAnimation = CAKeyframeAnimation(keyPath: AnimationKeys.transformScale.rawValue)
		scaleAnimation.values = [0, 1, 0]
		scaleAnimation.isAdditive = true


		animationGroup.animations = [rotationAnimation, scaleAnimation]
		return animationGroup
	}

	func updated(duration: CGFloat? = nil,
				 timingFunction: CAMediaTimingFunction? = nil,
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
		if let clockwise {
			let direction: Float = clockwise ? 1.0 : -1.0
			copyAnimation.values = [0, direction * Float.pi / 6, 0]
			copyAnimation.isAdditive = true
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
