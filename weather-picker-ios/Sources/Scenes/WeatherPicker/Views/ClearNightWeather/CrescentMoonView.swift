//
//  CrescentMoonView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

final class CrescentMoonView: UIView {
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

		// Define the moon path using Bezier curves
		let moonPath = UIBezierPath()
		let maskLayer = CAShapeLayer()

		// Define the start point
		let startPoint = CGPoint(x: rect.width * 0.5, y: rect.height * 0.1)
		moonPath.move(to: startPoint)

		// Define the control points and end point for the outer curve
		let outerControlPoint1 = CGPoint(x: rect.width * 1.1, y: rect.height * 0.1)
		let outerControlPoint2 = CGPoint(x: rect.width * 1.1, y: rect.height * 0.9)
		let outerEndPoint = CGPoint(x: rect.width * 0.5, y: rect.height * 0.9)

		moonPath.addCurve(to: outerEndPoint, controlPoint1: outerControlPoint1, controlPoint2: outerControlPoint2)

		// Define the control points and end point for the inner curve
		let innerControlPoint1 = CGPoint(x: rect.width * 0.8, y: rect.height * 0.8)
		let innerControlPoint2 = CGPoint(x: rect.width * 0.8, y: rect.height * 0.2)
		let innerEndPoint = startPoint

		moonPath.addCurve(to: innerEndPoint, controlPoint1: innerControlPoint1, controlPoint2: innerControlPoint2)

		// Close the path
		moonPath.close()
		maskLayer.path = moonPath.cgPath
		gradient.mask = maskLayer

		// Set fill color
		moonPath.fill()

		addShadow(offset: .init(width: 0, height: 0), radius: 20, color: AppColors.Gradient.Moon.moonTertiary, opacity: 1)
		layer.shadowPath = moonPath.cgPath
	}

	// MARK: - Private

	private let gradient = CAGradientLayer.AppGradients.moonGradient

	private func setup() {
		backgroundColor = .clear
		layer.addSublayer(gradient)
	}
}

// MARK: - ViewAnimatable

extension CrescentMoonView: ViewAnimatable {
	func startAnimation(completion: @escaping (() -> Void)) {
		layer.add(Constants.startScaleAnimation, forKey: UUID().uuidString)
		layer.add(Constants.startPositionYAnimation, forKey: UUID().uuidString)

		layer.add(CAKeyframeAnimation.makeAnimation(
			keyPath: .transformRotationZ,
			duration: 90,
			values: [0, .pi / 9, 0, -.pi / 9, 0]
		), forKey: UUID().uuidString)
	}
	
	func stopAnimation(completion: @escaping (() -> Void)) {
		layer.add(Constants.startScaleAnimation.updated(
			values: [0, 0.2, 0.25, 0.15, -0.1, -0.4, -1],
			shouldRemove: false
		), forKey: UUID().uuidString)
		layer.add(Constants.startPositionYAnimation.updated(
			values: [0, 60, 80, 85, 90, Float(-UIApplication.shared.windowSize.height)],
			shouldRemove: false
		), forKey: UUID().uuidString)
	}
}

// MARK: - Constants

private extension CrescentMoonView {
	enum Constants {
		static let startScaleAnimation = CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			values: [0, 0.2, 0.25, 0.15, -0.1, -0.4, -1].reversed(),
			repeatCount: 1
		)

		static let startPositionYAnimation = CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			values: [Float(-UIApplication.shared.windowSize.height), 80, 60, 40, 20, 0],
			repeatCount: 1
		)
	}
}
