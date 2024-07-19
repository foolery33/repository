//
//  RoadView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 19.07.2024.
//

import UIKit

final class RoadView: UIView {
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
		roadGradient.frame = bounds
	}

	override func draw(_ rect: CGRect) {
		super.draw(rect)
		let roadPath = UIBezierPath.makeRoadPath(rect)
		let roadShape = CAShapeLayer()
		roadShape.path = roadPath.cgPath
		roadGradient.mask = roadShape
	}

	// MARK: - Private

	private let roadGradient = CAGradientLayer.AppGradients.roadGradient

	private func setup() {
		backgroundColor = .clear
		layer.addSublayer(roadGradient)
		roadGradient.opacity = 0
	}
}

// MARK: - ViewAnimatable

extension RoadView: ViewAnimatable {
	func startAnimation(completion: @escaping (() -> Void)) {
		roadGradient.add(roadGradientOpacityStartAnimation, forKey: UUID().uuidString)
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		roadGradient.add(
			roadGradientOpacityStartAnimation.updated(
				toValue: 0,
				shouldRemove: false
			),
			forKey: UUID().uuidString
		)
	}
}

// MARK: - Animations

private extension RoadView {
	var roadGradientOpacityStartAnimation: CABasicAnimation {
		CABasicAnimation.makeAnimation(
			keyPath: .opacity,
			duration: 10,
			toValue: 1,
			repeatCount: 1,
			shouldRemove: false
		)
	}
}

