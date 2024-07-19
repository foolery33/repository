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

	private var snowflakeViews: [DrawableView] = []
	private let snowdriftView = DrawableView(drawingType: .snowdrift)
	private let snowflakeCount = 100

	private func setup() {
		setupSnowflakeViews()
		setupSnowdriftView()
		setupGradients()
		setupAnimations()
		startAnimation {}
	}

	private func setupSnowflakeViews() {
		for _ in 0..<snowflakeCount {
			let snowflakeSize = Double.random(in: 3...20)
			let snowflake = DrawableView(
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

		snowdriftView.snp.makeConstraints { make in
			make.bottom.horizontalEdges.equalToSuperview()
			make.height.equalToSuperview().multipliedBy(0.8)
		}
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
}

// MARK: - ViewAnimatable

extension SnowyWeatherView: ViewAnimatable {
	func startAnimation(completion: @escaping (() -> Void)) {
		for snowflakeView in snowflakeViews {
			snowflakeView.startAnimation {}
		}

		snowdriftView.startAnimation {}
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
			duration: 3,
			toValue: 1,
			repeatCount: 1,
			shouldRemove: false
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
			repeatCount: 1,
			shouldRemove: false
		)
	}

	func snowflakeMovingAnimation(frame: CGRect) -> CAAnimationGroup {
		let group = CAAnimationGroup()
		group.duration = .random(in: 10...30)
		let targetPoint = frame.origin.nearestToEdge(withOffset: frame.size.width + 5).pointOnDifferentEdge()
		group.animations = [
			snowflakePositionXAnimation(initialX: frame.origin.x, targetX: targetPoint.x),
			snowflakePositionYAnimation(initialY: frame.origin.y, targetY: targetPoint.y)
		]
		group.repeatCount = .infinity
		return group
	}

	func snowflakePositionXAnimation(initialX: CGFloat, targetX: CGFloat) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: 2,
			clockwise: targetX > initialX,
			values: [0, abs(Float(initialX - targetX)) + 30]
		)
	}

	func snowflakePositionYAnimation(initialY: CGFloat, targetY: CGFloat) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: 2,
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
			duration: 2,
			values: [0, Float(UIApplication.shared.windowSize.height)]
		)
	}
}
