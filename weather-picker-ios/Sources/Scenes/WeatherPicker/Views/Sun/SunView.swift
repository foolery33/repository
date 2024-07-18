//
//  SunView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

final class SunView: UIView {
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
		sunGradientLayer.frame = sunView.bounds
		sunGradientLayer.cornerRadius = sunDiameter / 2
	}

	// MARK: - Private

	private let sunView = UIView()
	private var rayViews = [UIView]()
	private let sunGradientLayer = CAGradientLayer.AppGradients.sunGradient

	private let sunDiameter: CGFloat = UIApplication.shared.windowSize.width / 2.5
	private let rayLength: CGFloat = UIApplication.shared.windowSize.width / 4
	private let numberOfRays = 12
	private lazy var rayWidth: CGFloat = .pi * sunDiameter / CGFloat(numberOfRays) - 20

	private func setup() {
		setupSunView()
		setupRays()
		startAnimation() {}
	}

	private func setupSunView() {
		sunView.backgroundColor = .clear
		sunView.layer.cornerRadius = sunDiameter / 2
		sunView.layer.addSublayer(sunGradientLayer)
		sunView.addShadow(offset: .init(width: -4, height: -4), radius: 10, color: .yellow)
		sunView.layer.shadowPath = UIBezierPath(rect: sunView.bounds).cgPath
		sunView.translatesAutoresizingMaskIntoConstraints = false

		addSubview(sunView)
		NSLayoutConstraint.activate([
			sunView.widthAnchor.constraint(equalToConstant: sunDiameter),
			sunView.heightAnchor.constraint(equalToConstant: sunDiameter),
			sunView.centerXAnchor.constraint(equalTo: centerXAnchor),
			sunView.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}

	private func setupRays() {
		for i in 0..<numberOfRays {
			let rayView = SunRayView(rayColor: AppColors.orangeYellow)
			rayView.translatesAutoresizingMaskIntoConstraints = false
			rayViews.append(rayView)
			addSubview(rayView)

			let angle = CGFloat(i) * (2 * .pi / CGFloat(numberOfRays))

			// * 0.99, чтобы убрать небольшой отступ между лучами и солнцем
			let xOffset = (cos(angle) * (sunDiameter / 2 + rayLength / 2)) * 0.99
			let yOffset = (sin(angle) * (sunDiameter / 2 + rayLength / 2)) * 0.99

			NSLayoutConstraint.activate([
				rayView.widthAnchor.constraint(equalToConstant: rayWidth),
				rayView.heightAnchor.constraint(equalToConstant: rayLength),
				rayView.centerXAnchor.constraint(equalTo: sunView.centerXAnchor, constant: xOffset),
				rayView.centerYAnchor.constraint(equalTo: sunView.centerYAnchor, constant: yOffset)
			])

			rayView.transform = CGAffineTransform(rotationAngle: angle - .pi / 2)
		}
		bringSubviewToFront(sunView)
	}
}

// MARK: - ViewAnimatable

extension SunView: ViewAnimatable {
	func startAnimation(completion: @escaping (() -> Void)) {
		sunView.layer.add(CABasicAnimation.makeRotationAnimation(angle: 2 * CGFloat.pi, duration: 60), forKey: nil)
		layer.add(CABasicAnimation.makeRotationAnimation(angle: 2 * CGFloat.pi, clockwise: false , duration: 180), forKey: nil)
		layer.add(Constants.startRotationZAnimation, forKey: UUID().uuidString)
		layer.add(Constants.startPositionYAnimation, forKey: UUID().uuidString)
		layer.add(Constants.startScaleAnimation, forKey: UUID().uuidString)
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		layer.add(Constants.startRotationZAnimation.updated(
			values: [0, Float.pi / 4, Float.pi / 2, Float.pi * 0.75, Float.pi, Float.pi * 1.25, Float.pi * 2, Float.pi * 4, Float.pi * 8]
		), forKey: UUID().uuidString)
		layer.add(Constants.startPositionYAnimation.updated(
			timingFunction: CAMediaTimingFunction(name: .easeOut),
			values: [0, -80, -120, 120, -1000],
			shouldRemove: false
		), forKey: UUID().uuidString)
		layer.add(Constants.startScaleAnimation.updated(
			timingFunction: CAMediaTimingFunction(name: .easeOut),
			values: [0, 0.5, 0.6, -0.1, -1]
		), forKey: UUID().uuidString)

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}

// MARK: - Constants

private extension SunView {
	enum Constants {
		static let startRotationZAnimation = CAKeyframeAnimation.makeAnimation(
			keyPath: .transformRotationZ,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			values: [Float.pi * 8, Float.pi * 4, Float.pi * 2, Float.pi * 1.25, Float.pi * 0.75, Float.pi / 2, Float.pi / 4, 0],
			repeatCount: 1
		)

		static let startPositionYAnimation = CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeIn),
			values: [-1000, 120, -120, -80, 0],
			repeatCount: 1
		)

		static let startScaleAnimation = CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeIn),
			values: [-1, -0.1, 0.6, 0.5, 0],
			repeatCount: 1
		)
	}
}
