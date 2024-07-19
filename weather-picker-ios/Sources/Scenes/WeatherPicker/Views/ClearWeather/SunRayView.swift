//
//  SunRayView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

final class SunRayView: UIView {
	// MARK: - Init

	init(rayColor: UIColor) {
		self.rayColor = rayColor
		super.init(frame: .zero)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func layoutSubviews() {
		super.layoutSubviews()
		gradient.frame = bounds
		layer.shadowPath = UIBezierPath(rect: bounds).cgPath
	}

	// MARK: - Override

	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else { return }

		context.beginPath()
		context.move(to: CGPoint(x: rect.width / 2, y: rect.height))
		context.addLine(to: CGPoint(x: 0, y: 0))
		context.addLine(to: CGPoint(x: rect.width, y: 0))
		context.closePath()

		context.setFillColor(rayColor.cgColor)
		context.fillPath()

		setupGradient()
		addShadow(offset: .init(width: 0, height: 0), radius: 30, color: AppColors.Gradient.Sun.sunSecondary, opacity: 1)
	}

	// MARK: - Private

	private let rayColor: UIColor
	private let gradient = CAGradientLayer.AppGradients.makeRandomColorsPlacementGradient(
		colors: [
			AppColors.Gradient.Sun.sunTertiary.cgColor,
			AppColors.Gradient.Sun.sunQuaternary.cgColor
		]
	)

	private func setup() {
		backgroundColor = .clear
		layer.addSublayer(gradient)
	}

	private func setupGradient() {
		let maskLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.move(to: CGPoint(x: bounds.width / 2, y: bounds.height))
		path.addLine(to: CGPoint(x: 0, y: 0))
		path.addLine(to: CGPoint(x: bounds.width, y: 0))
		path.closeSubpath()

		maskLayer.path = path
		gradient.mask = maskLayer
	}
}
