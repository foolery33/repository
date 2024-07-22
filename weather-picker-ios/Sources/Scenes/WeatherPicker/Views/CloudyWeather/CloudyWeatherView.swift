//
//  CloudyWeatherView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 18.07.2024.
//

import UIKit

final class CloudyWeatherView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private

	private var cloudViews: [BaseDrawableView] = []

	private func setup() {
		setupCloudViews()
		setupGradients()
		setupAnimations()
		startAnimation()
	}

	private func setupCloudViews() {
		for i in 0..<Constants.cloudCount {
			let cloudWidth = randomCloudWidth
			let cloud = BaseDrawableView(
				drawingType: .cloud,
				frame: getRandomCloudFrame(index: i, cloudWidth: cloudWidth)
			)

			let isMirrored: Bool = .random()
			if isMirrored {
				cloud.transform = Constants.mirroredCloudTransform
			}

			addSubview(cloud)
			cloudViews.append(cloud)
		}
	}

	private func setupGradients() {
		for cloudView in cloudViews {
			cloudView.addGradient(CAGradientLayer.AppGradients.cloudGradient)
		}
	}

	private func setupAnimations() {
		for (index, cloudView) in cloudViews.enumerated() {
			let direction = index < Constants.cloudCount / 2 ? true : false
			let dY = randomCloudAnimationYOffset
			cloudView.setAnimations(
				startAnimations: [
					(cloudStartScaleAnimation, UUID().uuidString),
					(cloudStartPositionXAnimation(direction: direction), UUID().uuidString),
					(cloudPositionXAnimation(direction: direction), UUID().uuidString),
					(cloudPositionYAnimation(dY: dY), UUID().uuidString)
				],
				stopAnimations: [
					(cloudStopScaleAnimation(direction: cloudView.transform.isIdentity), UUID().uuidString),
					(cloudStopPositionXAnimation(direction: direction), UUID().uuidString)
				]
			)
		}
	}
}

// MARK: - ViewAnimatable

extension CloudyWeatherView: ViewAnimatable {
	func startAnimation() {
		for cloudView in cloudViews {
			cloudView.startAnimation()
		}
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		for cloudView in self.cloudViews {
			cloudView.stopAnimation {}
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}

// MARK: - Animations

private extension CloudyWeatherView {
	var cloudStartScaleAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			direction: transform.isIdentity,
			values: [-1, 0, 0.15, 0],
			repeatCount: 1
		)
	}

	func cloudStopScaleAnimation(direction: Bool) -> CAKeyframeAnimation {
		cloudStartScaleAnimation.updated(
			direction: direction,
			values: [0, 0.3, -1]
		)
	}

	func cloudStopPositionXAnimation(direction: Bool) -> CAKeyframeAnimation {
		cloudStartPositionXAnimation(direction: direction).updated(
			direction: direction,
			values: [Float(-UIApplication.shared.windowSize.width), -300, -200, -100, -50, -30, -20, -10, -5, 0].reversed()
		)
	}

	func cloudPositionYAnimation(dY: Float) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: .random(in: 100...200),
			direction: .random(),
			values: [0, dY, 0, -dY, 0]
		)
	}

	func cloudPositionXAnimation(direction: Bool) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: .random(in: 100...200),
			direction: direction,
			values: [0, Float(UIApplication.shared.windowSize.width / 2), 0]
		)
	}

	func cloudStartPositionXAnimation(direction: Bool) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeOut),
			direction: direction,
			values: [Float(-2 * UIApplication.shared.windowSize.width), -300, -200, -100, -50, -30, -20, -10, -5, 0],
			repeatCount: 1
		)
	}
}

// MARK: - Constants and helpers

private extension CloudyWeatherView {
	enum Constants {
		static let cloudCount = 12
		static let mirroredCloudTransform = CGAffineTransform(scaleX: -1, y: 1)
	}

	var randomCloudAnimationYOffset: Float {
		Float.random(in: -50...200)
	}

	var randomCloudWidth: CGFloat {
		.random(in: UIApplication.shared.windowSize.width * 0.5...UIApplication.shared.windowSize.width * 0.8)
	}

	func getRandomCloudFrame(index: Int, cloudWidth: CGFloat) -> CGRect {
		let screenSize = UIApplication.shared.windowSize
		return CGRect(
			x: CGFloat.random(
				in: (index < Constants.cloudCount / 2) ? -cloudWidth / 2...screenSize.width / 2 - cloudWidth / 2 : screenSize.width / 2 - cloudWidth / 2...screenSize.width - cloudWidth / 2
			),
			y: CGFloat.random(in: screenSize.height / 7...screenSize.height - screenSize.height / 4),
			width: cloudWidth,
			height: cloudWidth / 2
		)
	}
}
