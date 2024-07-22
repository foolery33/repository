//
//  SnowyWeatherView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 19.07.2024.
//

import UIKit

final class SnowyWeatherView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private

	private var snowflakeViews: [BaseDrawableView] = []
	private let snowdriftView = BaseDrawableView(drawingType: .snowdrift)

	private func setup() {
		setupSnowflakeViews()
		setupSnowdriftView()
		setupGradients()
		setupAnimations()
		startAnimation()
	}

	private func setupSnowflakeViews() {
		for _ in 0..<Constants.snowflakeCount {
			let snowflakeSize = Double.random(in: 3...20)
			let snowflake = BaseDrawableView(
				drawingType: .snowflake,
				frame: CGRect(
					origin: CGPoint.randomTopPoint(withOffset: snowflakeSize),
					size: CGSize(width: snowflakeSize, height: snowflakeSize)
				)
			)
			snowflake.layer.opacity = 0
			snowflake.transform = CGAffineTransform(rotationAngle: .random(in: 0...CGFloat.pi * 2))

			addSubview(snowflake)
			snowflakeViews.append(snowflake)
		}
	}

	private func setupSnowdriftView() {
		addSubview(snowdriftView)

		snowdriftView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			snowdriftView.bottomAnchor.constraint(equalTo: bottomAnchor),
			snowdriftView.leadingAnchor.constraint(equalTo: leadingAnchor),
			snowdriftView.trailingAnchor.constraint(equalTo: trailingAnchor),
			snowdriftView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.showdriftHeightMultiplier)
		])
	}

	private func setupGradients() {
		snowdriftView.addGradient(CAGradientLayer.AppGradients.snowdriftGradient)
	}

	private func setupAnimations() {
		for snowflakeView in snowflakeViews {
			snowflakeView.setAnimations(
				startAnimations: [
					(snowflakeStartOpacityAnimation, UUID().uuidString),
					(snowflakeRotationAnimation, UUID().uuidString),
				],
				stopAnimations: [
					(snowflakeStopOpacityAnimation, UUID().uuidString)
				]
			)

			snowflakeView.setDelayedAnimation(
				(snowflakeMovingAnimation(frame: snowflakeView.frame), UUID().uuidString),
				delay: Double.random(in: 0...20)
			)
		}

		snowdriftView.setAnimations(
			startAnimations: [
				(snowdriftStartPositionYAnimation, UUID().uuidString)
			],
			stopAnimations: [
				(snowdriftStopPositionYAnimation, UUID().uuidString)
			]
		)
	}

	// TODO: - Переместить

	private func snowflakeEndPoint() -> CGPoint {

		let screenSize = UIApplication.shared.windowSize

		let edge = Int.random(in: 0...2)
		switch edge {
		case 0:
			return CGPoint(x: 0, y: CGFloat.random(in: 40...screenSize.height))
		case 1:
			return CGPoint(x: screenSize.width, y: CGFloat.random(in: 40...screenSize.height))
		default:
			return CGPoint(x: CGFloat.random(in: 0...screenSize.width), y: screenSize.height)
		}
	}
}

// MARK: - ViewAnimatable

extension SnowyWeatherView: ViewAnimatable {
	func startAnimation() {
		for snowflakeView in snowflakeViews {
			snowflakeView.startAnimation()
		}

		snowdriftView.startAnimation()
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		for snowflakeView in self.snowflakeViews {
			snowflakeView.stopAnimation {}
		}

		snowdriftView.stopAnimation {}

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}

// MARK: - Animations

private extension SnowyWeatherView {
	// Snowflake

	var snowflakeStartOpacityAnimation: CABasicAnimation {
		CABasicAnimation.makeAnimation(
			keyPath: .opacity,
			duration: 2,
			toValue: 1,
			repeatCount: 1
		)
	}

	var snowflakeRotationAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformRotationZ,
			duration: .random(in: 2...8),
			clockwise: .random(),
			values: [0, 2 * Float.pi]
		)
	}

	var snowdriftStartPositionYAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: 1,
			values: [Float(UIApplication.shared.windowSize.height), 0],
			repeatCount: 1
		)
	}

	func snowflakeMovingAnimation(frame: CGRect) -> CAAnimationGroup {
		let group = CAAnimationGroup()

		let screenSize = UIApplication.shared.windowSize
		let offset = frame.size.width
		let duration = Double.random(in: 10...30)
		group.duration = duration

		let targetPoint = CGPoint(x: .random(in: -screenSize.width / 2...screenSize.width * 3 / 2), y: screenSize.height + offset)

		group.animations = [
			snowflakePositionXAnimation(initialX: frame.origin.x, targetX: targetPoint.x),
			snowflakePositionYAnimation(initialY: frame.origin.y, targetY: targetPoint.y)
		]
		group.isRemovedOnCompletion = false
		group.fillMode = .forwards
		group.repeatCount = .infinity
		return group
	}

	func snowflakePositionXAnimation(initialX: CGFloat, targetX: CGFloat) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: 0,
			clockwise: targetX > initialX,
			values: [0, abs(Float(initialX - targetX)) + 30]
		)
	}

	func snowflakePositionYAnimation(initialY: CGFloat, targetY: CGFloat) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: 0,
			clockwise: targetY > initialY,
			values: [0, abs(Float(initialY - targetY)) + 30]
		)
	}

	var snowflakeStopOpacityAnimation: CAAnimation {
		snowflakeStartOpacityAnimation.updated(
			duration: 1,
			toValue: 0
		)
	}

	var snowdriftStopPositionYAnimation: CAAnimation {
		snowdriftStartPositionYAnimation.updated(
			duration: 1,
			values: [0, Float(UIApplication.shared.windowSize.height * Constants.showdriftHeightMultiplier)]
		)
	}
}

// MARK: - Constants

private extension SnowyWeatherView {
	enum Constants {
		static let snowflakeCount = 100
		static let showdriftHeightMultiplier = 0.8
	}
}
