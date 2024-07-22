//
//  ClearWeatherView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

final class ClearWeatherView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Override

	override func layoutSubviews() {
		super.layoutSubviews()
		sunGradientLayer.frame = sunView.bounds
		sunGradientLayer.cornerRadius = Constants.sunDiameter / 2
	}

	// MARK: - Private

	private let sunView = UIView()
	private var rayViews: [BaseDrawableView] = []
	private let sunGradientLayer = CAGradientLayer.AppGradients.sunGradient

	private func setup() {
		setupSunView()
		setupRayViews()
		setupGradients()
		startAnimation()
	}

	private func setupSunView() {
		sunView.backgroundColor = AppColors.clear
		sunView.layer.cornerRadius = Constants.sunDiameter / 2
		sunView.layer.addSublayer(sunGradientLayer)
		sunView.addShadow(offset: .init(width: -4, height: -4), radius: 30, color: AppColors.Gradient.View.Sun.sunSecondary, opacity: 1)
		sunView.translatesAutoresizingMaskIntoConstraints = false

		addSubview(sunView)
		NSLayoutConstraint.activate([
			sunView.widthAnchor.constraint(equalToConstant: Constants.sunDiameter),
			sunView.heightAnchor.constraint(equalToConstant: Constants.sunDiameter),
			sunView.centerXAnchor.constraint(equalTo: centerXAnchor),
			sunView.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}

	private func setupRayViews() {
		for i in 0..<Constants.numberOfRays {
			let rayView = BaseDrawableView(drawingType: .sunRay)
			rayView.translatesAutoresizingMaskIntoConstraints = false
			rayViews.append(rayView)
			addSubview(rayView)
			rayView.addShadow(offset: .init(width: 0, height: 30), radius: 20, color: AppColors.Gradient.View.Sun.sunSecondary)

			let angle = CGFloat(i) * (2 * .pi / CGFloat(Constants.numberOfRays))

			let xOffset = (cos(angle) * (Constants.sunDiameter / 2 + Constants.rayLength / 2)) * 0.99
			let yOffset = (sin(angle) * (Constants.sunDiameter / 2 + Constants.rayLength / 2)) * 0.99

			NSLayoutConstraint.activate([
				rayView.widthAnchor.constraint(equalToConstant: Constants.rayWidth),
				rayView.heightAnchor.constraint(equalToConstant: Constants.rayLength),
				rayView.centerXAnchor.constraint(equalTo: sunView.centerXAnchor, constant: xOffset),
				rayView.centerYAnchor.constraint(equalTo: sunView.centerYAnchor, constant: yOffset)
			])

			rayView.transform = CGAffineTransform(rotationAngle: angle - .pi / 2)
		}
		bringSubviewToFront(sunView)
	}

	private func setupGradients() {
		for rayView in rayViews {
			rayView.addGradient(CAGradientLayer.AppGradients.sunRayGradient)
		}
	}
}

// MARK: - ViewAnimatable

extension ClearWeatherView: ViewAnimatable {
	func startAnimation() {
		sunView.layer.add(sunViewRotationAnimation, forKey: UUID().uuidString)
		layer.add(rotationAnimation, forKey: UUID().uuidString)
		layer.add(startRotationZAnimation, forKey: UUID().uuidString)
		layer.add(startPositionYAnimation, forKey: UUID().uuidString)
		layer.add(startScaleAnimation, forKey: UUID().uuidString)
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		layer.add(stopRotationZAnimation, forKey: UUID().uuidString)
		layer.add(stopPositionYAnimation, forKey: UUID().uuidString)
		layer.add(stopScaleAnimation, forKey: UUID().uuidString)

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}

// MARK: - Animations

private extension ClearWeatherView {
	// SunView

	var sunViewRotationAnimation: CABasicAnimation {
		CABasicAnimation.makeAnimation(
			keyPath: .transformRotationZ,
			duration: 60,
			toValue: Float.pi * 2
		)
	}

	// Self

	var rotationAnimation: CABasicAnimation {
		CABasicAnimation.makeAnimation(
			keyPath: .transformRotationZ,
			duration: 180,
			toValue: -Float.pi * 2
		)
	}

	var startRotationZAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformRotationZ,
			   duration: 1,
			   timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			   values: [Float.pi * 8, Float.pi * 4, Float.pi * 2, Float.pi * 1.25, Float.pi * 0.75, Float.pi / 2, Float.pi / 4, 0],
			   repeatCount: 1
		   )
	}

	var startPositionYAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeIn),
			values: [-1000, 120, -120, -80, 0],
			repeatCount: 1
		)
	}

	var startScaleAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeIn),
			values: [-1, -0.1, 0.6, 0.5, 0],
			repeatCount: 1
		)
	}

	var stopRotationZAnimation: CAKeyframeAnimation {
		startRotationZAnimation.updated(
			values: [0, Float.pi / 4, Float.pi / 2, Float.pi * 0.75, Float.pi, Float.pi * 1.25, Float.pi * 2, Float.pi * 4, Float.pi * 8]
		)
	}

	var stopPositionYAnimation: CAKeyframeAnimation {
		startPositionYAnimation.updated(
			timingFunction: CAMediaTimingFunction(name: .easeOut),
			values: [0, -80, -120, 120, -1000]
		)
	}

	var stopScaleAnimation: CAKeyframeAnimation {
		startScaleAnimation.updated(
			timingFunction: CAMediaTimingFunction(name: .easeOut),
			values: [0, 0.5, 0.6, -0.1, -1]
		)
	}
}

// MARK: - Constants

private extension ClearWeatherView {
	enum Constants {
		static let sunDiameter: CGFloat = UIApplication.shared.windowSize.width / 2.5
		static let rayLength: CGFloat = UIApplication.shared.windowSize.width / 4
		static let numberOfRays = 12
		static let rayWidth: CGFloat = .pi * sunDiameter / CGFloat(numberOfRays) - 20
	}
}
