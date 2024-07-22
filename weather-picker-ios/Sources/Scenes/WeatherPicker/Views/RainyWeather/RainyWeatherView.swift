//
//  RainyWeatherView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 19.07.2024.
//

import UIKit

final class RainyWeatherView: UIView {
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
	private var raindropViews: [BaseDrawableView] = []

	private func setup() {
		setupRaindropViews()
		setupCloudViews()
		setupGradients()
		setupAnimations()
		startAnimation()
	}

	private func setupCloudViews() {
		let screenSize = UIApplication.shared.windowSize
		let biggestCloudsXPositions: [CGFloat] = [-screenSize.width * 0.2, screenSize.width / 2 * 0.4, screenSize.width * 0.7]
		for i in 0..<Constants.cloudCount {
			let cloudWidth = UIApplication.shared.windowSize.width * CGFloat.random(in: 0.8...1)
			let xPosition = (i < 3) ? biggestCloudsXPositions[i] : .random(in: -cloudWidth / 2...screenSize.width / 2)
			let cloud = BaseDrawableView(
				drawingType: .cloud,
				frame: CGRect(
					x: xPosition,
					y: screenSize.height * 0.07,
					width: cloudWidth,
					height: cloudWidth / 2
				)
			)
			cloud.addShadow(offset: .zero, radius: 10, color: AppColors.Gradient.Background.RainyWeather.rainyTertiary, opacity: 1)

			let isMirrored: Bool = .random()
			if isMirrored {
				cloud.transform = CGAffineTransform(scaleX: -1, y: 1)
			}

			addSubview(cloud)
			cloudViews.append(cloud)
		}
	}

	private func setupRaindropViews() {
		for _ in 0..<Constants.raindropCount {
			let raindrop = BaseDrawableView(
				drawingType: Bool.random() == true ? .raindropFirst : .raindropSecond,
				frame: getRandomRaindropFrame()
			)
			raindrop.layer.opacity = 1
			raindrop.transform = CGAffineTransform(rotationAngle: .random(in: -.pi / 18...CGFloat.pi / 18))

			addSubview(raindrop)
			raindropViews.append(raindrop)
		}
	}

	private func setupGradients() {
		for cloudView in cloudViews {
			cloudView.addGradient(CAGradientLayer.AppGradients.cloudGradient)
		}

		for raindropView in raindropViews {
			raindropView.addGradient(CAGradientLayer.AppGradients.raindropGradient)
		}
	}

	private func setupAnimations() {
		for cloudView in cloudViews {
			cloudView.setAnimations(
				startAnimations: [
					(cloudStartScaleAnimation, UUID().uuidString),
					(cloudStartPositionXAnimation(frame: cloudView.frame), UUID().uuidString),
					(cloudPositionXAnimation(frame: cloudView.frame), UUID().uuidString),
					(cloudPositionYAnimation, UUID().uuidString)
				],
				stopAnimations: [
					(cloudStopScaleAnimation, UUID().uuidString),
					(cloudStopPositionXAnimation(frame: cloudView.frame), UUID().uuidString)
				]
			)
		}

		for raindropView in raindropViews {
			raindropView.setAnimations(
				startAnimations: [(raindropStartPositionXAnimation(
					direction: raindropView.frame.midX > UIApplication.shared.windowSize.width / 2 ? true : false
				), UUID().uuidString)],
				stopAnimations: [(raindropStopOpacityAnimation, UUID().uuidString)]
			)

			raindropView.setDelayedAnimation(
				(raindropMovingAnimation(
					xOffset: Float(calculateFinalX(
						startPoint: raindropView.frame.origin,
						angle: .pi / 2 - raindropView.rotationAngleInRadians,
						finalY: UIApplication.shared.windowSize.height - Constants.raindropTopOffset
					)),
					raindropHeight: raindropView.bounds.height,
					direction: raindropView.rotationAngleInRadians < 0
				), UUID().uuidString),
				delay: Double.random(in: 1...5)
			)
		}
	}
}

// MARK: - ViewAnimatable

extension RainyWeatherView: ViewAnimatable {
	func startAnimation() {
		for cloudView in cloudViews {
			cloudView.startAnimation()
		}
		for raindropView in raindropViews {
			raindropView.startAnimation()
		}
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		for cloudView in cloudViews {
			cloudView.stopAnimation {}
		}
		for raindropView in raindropViews {
			raindropView.stopAnimation {}
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}

// MARK: - Animations

private extension RainyWeatherView {
	// Raindrop

	var raindropStopOpacityAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 0.5,
			isAdditive: false,
			values: [1, 0],
			repeatCount: 1
		)
	}

	func raindropStartPositionXAnimation(direction: Bool) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: 1,
			direction: direction,
			values: [Float(UIApplication.shared.windowSize.width), 0],
			repeatCount: 1
		)
	}

	func raindropMovingAnimation(xOffset: Float, raindropHeight: Double, direction: Bool) -> CAAnimationGroup {
		let group = CAAnimationGroup()
		let duration: CGFloat = .random(in: 0.3...1.5)
		group.duration = duration
		group.animations = [raindropPositionYAnimation(raindropHeight: raindropHeight, duration: duration), raindropPositionXAnimation(xOffset: xOffset, direction: direction, duration: duration)]
		group.isRemovedOnCompletion = false
		group.fillMode = .forwards
		group.repeatCount = .infinity
		return group
	}

	func raindropPositionYAnimation(raindropHeight: Double, duration: CGFloat) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: duration,
			values: [0, Float(UIApplication.shared.windowSize.height - Constants.raindropTopOffset + raindropHeight)]
		)
	}

	func raindropPositionXAnimation(xOffset: Float, direction: Bool, duration: CGFloat) -> CAKeyframeAnimation {
		return CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: duration,
			direction: direction,
			values: [0, xOffset]
		)
	}

	// MARK: - Cloud

	var cloudPositionYAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: .random(in: 60...100),
			direction: .random(),
			values: [0, 10, 0, -10, 0]
		)
	}

	var cloudStartScaleAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			direction: transform.isIdentity,
			values: [-0.4, 0, 0.15, 0],
			repeatCount: 1
		)
	}

	var cloudStopScaleAnimation: CAKeyframeAnimation {
		cloudStartScaleAnimation.updated(
			direction: transform.isIdentity,
			values: [0, -0.4]
		)
	}

	func cloudStartPositionXAnimation(frame: CGRect) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeOut),
			direction: isForwardCloudAnimationDirection(frame: frame),
			values: [Float(-UIApplication.shared.windowSize.width), -300, -200, -100, -50, -30, -20, -10, -5, 0],
			repeatCount: 1
		)
	}

	func cloudPositionXAnimation(frame: CGRect) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: .random(in: 100...200),
			direction: isForwardCloudAnimationDirection(frame: frame),
			values: [0, 40, 0]
		)
	}

	func cloudStopPositionXAnimation(frame: CGRect) -> CAKeyframeAnimation {
		cloudStartPositionXAnimation(frame: frame).updated(
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			direction: .random(),
			values: [Float(-UIApplication.shared.windowSize.width - frame.size.width), -300, -200, -100, -50, -30, -20, -10, -5, 0].reversed()
		)
	}
}

// MARK: - Constants and helpers

private extension RainyWeatherView {
	enum Constants {
		static let cloudCount = 5
		static let raindropCount = 100
		static let raindropTopOffset = UIApplication.shared.windowSize.height * 0.2
	}

	func getRandomRaindropFrame() -> CGRect {
		let raindropHeight = Double.random(in: 10...40)
		let screenSize = UIApplication.shared.windowSize
		return CGRect(
			origin: CGPoint(
				x: .random(in: 0...screenSize.width),
				y: Constants.raindropTopOffset
			),
			size: CGSize(width: raindropHeight / 4, height: raindropHeight)
		)
	}

	func calculateFinalX(startPoint: CGPoint, angle: CGFloat, finalY: CGFloat) -> CGFloat {
		let dx = finalY / tan(angle)

		return angle < .pi / 2 ? dx : -dx
	}

	func isForwardCloudAnimationDirection(frame: CGRect) -> Bool {
		frame.minX < UIApplication.shared.windowSize.width / 2 ? true : false
	}
}
