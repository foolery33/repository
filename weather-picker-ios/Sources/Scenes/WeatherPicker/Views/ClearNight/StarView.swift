//
//  StarView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

final class StarView: UIView {
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

		// Create the diamond path with rounded inward sides
		let path = UIBezierPath()
		let maskLayer = CAShapeLayer()

		// Define the points for the diamond
		let topPoint = CGPoint(x: rect.midX, y: rect.minY)
		let rightPoint = CGPoint(x: rect.maxX, y: rect.midY)
		let bottomPoint = CGPoint(x: rect.midX, y: rect.maxY)
		let leftPoint = CGPoint(x: rect.minX, y: rect.midY)

		// Move to the top point
		path.move(to: topPoint)

		// Add curves to each side of the diamond
		path.addCurve(to: rightPoint,
					  controlPoint1: CGPoint(x: rect.midX + rect.width * 0.1, y: rect.minY + rect.height * 0.3),
					  controlPoint2: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.midY - rect.height * 0.1))

		path.addCurve(to: bottomPoint,
					  controlPoint1: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.midY + rect.height * 0.1),
					  controlPoint2: CGPoint(x: rect.midX + rect.width * 0.1, y: rect.maxY - rect.height * 0.3))

		path.addCurve(to: leftPoint,
					  controlPoint1: CGPoint(x: rect.midX - rect.width * 0.1, y: rect.maxY - rect.height * 0.3),
					  controlPoint2: CGPoint(x: rect.minX + rect.width * 0.3, y: rect.midY + rect.height * 0.1))

		path.addCurve(to: topPoint,
					  controlPoint1: CGPoint(x: rect.minX + rect.width * 0.3, y: rect.midY - rect.height * 0.1),
					  controlPoint2: CGPoint(x: rect.midX - rect.width * 0.1, y: rect.minY + rect.height * 0.3))

		// Close the path
		path.close()

		// Set fill color
		path.fill()

		maskLayer.path = path.cgPath
		gradient.mask = maskLayer

		addShadow(offset: .init(width: 0, height: 0), radius: 20, color: AppColors.Gradient.Moon.moonTertiary, opacity: 1)
		layer.shadowPath = path.cgPath
	}

	// MARK: - Private

	private let clockwiseAnimation: Bool = .random()
	private let gradient = CAGradientLayer.AppGradients.starGradient
	private lazy var shineAnimation = CAKeyframeAnimation.makeStarShiningAnimation(duration: 1, clockwise: clockwiseAnimation)

	private func setup() {
		backgroundColor = .clear
		layer.addSublayer(gradient)
		shineAnimation.delegate = self
	}
}

// MARK: - ViewAnimatable

extension StarView: ViewAnimatable {
	func startAnimation(completion: @escaping (() -> Void)) {
		layer.add(CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			values: [0, 0.5, 0],
			repeatCount: 1
		), forKey: UUID().uuidString)
		layer.add(CAKeyframeAnimation.makeAnimation(
			keyPath: .transformRotationZ,
			duration: .random(in: 30...60),
			clockwise: clockwiseAnimation,
			values: [0, 2 * Float.pi]
		), forKey: UUID().uuidString)

		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(.random(in: 0...90))) {
			self.layer.add(self.shineAnimation, forKey: UUID().uuidString)
		}
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		layer.add(CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			values: [0, 0.5, 0.6, 0.7, 0.75, -1],
			repeatCount: 1,
			shouldRemove: false
		), forKey: "UUID().uuidString")
	}
}

// MARK: - CAAnimationDelegate

extension StarView: CAAnimationDelegate {
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		if flag {
			DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(.random(in: 10...60))) {
				self.layer.add(self.shineAnimation, forKey: UUID().uuidString)
			}
		}
	}
}
