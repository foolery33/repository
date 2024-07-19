//
//  CloudView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 18.07.2024.
//

import UIKit

final class CloudView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func layoutSubviews() {
		super.layoutSubviews()
		gradient.frame = bounds
	}

	// MARK: - Override

	override func draw(_ rect: CGRect) {
		super.draw(rect)

		let path = UIBezierPath()
		let maskLayer = CAShapeLayer()

		let verticalPadding: CGFloat = 2

		path.move(to: CGPoint(x: rect.width * 0.2, y: rect.height - verticalPadding))
		path.addLine(to: CGPoint(x: rect.width * 0.8, y: rect.height - verticalPadding))
		path.addCurve(
			to: CGPoint(x: rect.width * 0.8  - rect.width * 0.8 * 0.025, y: rect.height / 2),
			controlPoint1: CGPoint(x: rect.width * 0.98, y: rect.height - verticalPadding),
			controlPoint2: CGPoint(x: rect.width * 0.98, y: (rect.height - verticalPadding) / 2)
		)
		path.addCurve(
			to: CGPoint(x: rect.width / 2 + 20, y: rect.height / 3),
			controlPoint1: CGPoint(x: rect.width * 0.8  + rect.width * 0.8 * 0.05, y: rect.height / 5),
			controlPoint2: CGPoint(x: rect.width - rect.width / 2.4, y: rect.height - rect.height * 0.9)
		)
		path.addCurve(
			to: CGPoint(x: rect.width * 0.2, y: rect.height / 2),
			controlPoint1: CGPoint(x: rect.width / 2.4, y: rect.height - rect.height * 1.2),
			controlPoint2: CGPoint(x: rect.width / 10, y: rect.height - rect.height * 0.8)
		)
		path.addCurve(
			to: CGPoint(x: rect.width * 0.2, y: rect.height - verticalPadding),
			controlPoint1: CGPoint(x: rect.width / 98, y: (rect.height / verticalPadding) / 2),
			controlPoint2: CGPoint(x: rect.width / 98, y: rect.height - verticalPadding)
		)

		path.close()
		path.fill()

		maskLayer.path = path.cgPath
		gradient.mask = maskLayer

		addShadow(offset: .init(width: 0, height: 0), radius: 10, color: AppColors.Gradient.Cloud.cloudTertiary, opacity: 1)
		layer.shadowPath = path.cgPath
	}

	// MARK: - Private

	private let gradient = CAGradientLayer.AppGradients.cloudGradient
	private lazy var animationDirection = frame.minX < UIApplication.shared.windowSize.width / 2 ? true : false

	private func setup() {
		backgroundColor = .clear
		layer.addSublayer(gradient)
	}
}

// MARK: - ViewAnimatable

extension CloudView: ViewAnimatable {
	func startAnimation(completion: @escaping (() -> Void)) {
		let dY = Float.random(in: 5...200)
		layer.add(startScaleAnimation, forKey: UUID().uuidString)
		layer.add(startPositionXAnimation, forKey: UUID().uuidString)

		layer.add(CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: .random(in: 100...200),
			clockwise: animationDirection,
			values: [0, Float(UIApplication.shared.windowSize.width / 2), 0]
		), forKey: UUID().uuidString)

		layer.add(CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: .random(in: 100...200),
			clockwise: .random(),
			values: [0, dY, 0, -dY, 0]
		), forKey: UUID().uuidString)
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		layer.add(startScaleAnimation.updated(
			clockwise: transform.isIdentity,
			values: [0, -1],
			shouldRemove: false
		), forKey: UUID().uuidString)

		layer.add(startPositionXAnimation.updated(
			clockwise: animationDirection,
			values: [Float(-UIApplication.shared.windowSize.width), -300, -200, -100, -50, -30, -20, -10, -5, 0].reversed(),
			shouldRemove: false
		), forKey: UUID().uuidString)
	}
}

// MARK: - Animations

private extension CloudView {
	var startScaleAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			clockwise: transform.isIdentity,
			values: [-1, 0, 0.15, 0],
			repeatCount: 1
		)
	}

	var startPositionXAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeOut),
			clockwise: animationDirection,
			values: [Float(-UIApplication.shared.windowSize.width), -300, -200, -100, -50, -30, -20, -10, -5, 0],
			repeatCount: 1
		)
	}
}
