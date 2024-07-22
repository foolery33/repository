//
//  ClearNightWeatherView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

final class ClearNightWeatherView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private

	private let crescentMoonView = BaseDrawableView(drawingType: .crescentMoon)
	private var starViews: [BaseDrawableView] = []

	private func setup() {
		setupStarViews()
		setupCrescentMoonView()
		setupGradients()
		setupAnimations()
		startAnimation()
	}

	private func setupStarViews() {
		for _ in 0..<Constants.starsCount {
			let randomSize: Int = .random(in: 5...20)
			let frame = getRandomStarFrame(starSize: randomSize)
			let star = BaseDrawableView(drawingType: .star, frame: frame)
			star.transform = CGAffineTransform(rotationAngle: getRandomStarAngle())
			star.addShadow(offset: .init(width: 0, height: 0), radius: 10, color: AppColors.white, opacity: 1)

			starViews.append(star)
			addSubview(star)
		}
		bringSubviewToFront(crescentMoonView)
	}

	private func setupCrescentMoonView() {
		crescentMoonView.transform = CGAffineTransform(rotationAngle: Constants.crescentMoonRotationAngle)
		crescentMoonView.addShadow(offset: .init(width: 0, height: 0), radius: 20, color: AppColors.Gradient.View.Moon.moonTertiary, opacity: 1)

		addSubview(crescentMoonView)

		crescentMoonView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			crescentMoonView.widthAnchor.constraint(equalToConstant: Constants.moonSize),
			crescentMoonView.heightAnchor.constraint(equalToConstant: Constants.moonSize),
			crescentMoonView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: Constants.moonSize * 0.15),
			crescentMoonView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -(Constants.moonSize / 1.8))
		])
	}

	private func setupGradients() {
		for starView in starViews {
			starView.addGradient(CAGradientLayer.AppGradients.starGradient)
		}

		crescentMoonView.addGradient(CAGradientLayer.AppGradients.moonGradient)
	}

	private func setupAnimations() {
		for starView in starViews {
			let isClockwise = Bool.random()
			starView.setAnimations(
				startAnimations: [
					(starStartScaleAnimation, UUID().uuidString),
					(starRotationAnimation(clockwise: isClockwise), UUID().uuidString),
					(starShineScaleAnimation, Constants.starShineAnimationKey)
				],
				stopAnimations: [
					(starStopScaleAnimation, UUID().uuidString)
				]
			)
		}
	}
}

// MARK: - ViewAnimatable

extension ClearNightWeatherView: ViewAnimatable {
	func startAnimation() {
		crescentMoonView.layer.add(crescentMoonStartPositionYAnimation, forKey: UUID().uuidString)
		crescentMoonView.layer.add(crescentMoonStartScaleAnimation, forKey: UUID().uuidString)
		crescentMoonView.layer.add(crescentMoonRotationZAnimation, forKey: UUID().uuidString)

		for star in starViews {
			star.startAnimation()
		}
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		crescentMoonView.layer.add(crescentMoonStopPositionYAnimation, forKey: UUID().uuidString)
		crescentMoonView.layer.add(crescentMoonStopScaleAnimation, forKey: UUID().uuidString)

		for star in starViews {
			star.layer.removeAnimation(forKey: Constants.starShineAnimationKey)
			star.stopAnimation {}
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}

// MARK: - Animations

private extension ClearNightWeatherView {
	// Star

	var starStartScaleAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			values: [0, 0.5, 0],
			repeatCount: 1
		)
	}

	var starStopScaleAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeOut),
			values: [0.3, 0.5, 0.6, 0.7, 0.75, -1],
			repeatCount: 1
		)
	}

	var starShineScaleAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: .random(in: 1...2),
			values: [0, 0.5, 0]
		)
	}

	func starRotationAnimation(clockwise: Bool) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformRotationZ,
			duration: .random(in: 30...60),
			clockwise: clockwise,
			values: [0, 2 * Float.pi]
		)
	}

	// CrescentMoon

	var crescentMoonStartScaleAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			values: [0, 0.2, 0.25, 0.15, -0.1, -0.4, -1].reversed(),
			repeatCount: 1
		)
	}

	var crescentMoonStartPositionYAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			values: [Float(-UIApplication.shared.windowSize.height), 80, 60, 40, 20, 0],
			repeatCount: 1
		)
	}

	var crescentMoonRotationZAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformRotationZ,
			duration: 45,
			values: [0, .pi / 9, 0, -.pi / 9, 0]
		)
	}

	var crescentMoonStopScaleAnimation: CAKeyframeAnimation {
		crescentMoonStartScaleAnimation.updated(
			values: [0, 0.2, 0.25, 0.15, -0.1, -0.4, -1]
		)
	}

	var crescentMoonStopPositionYAnimation: CAKeyframeAnimation {
		crescentMoonStartPositionYAnimation.updated(
			values: [0, 60, 80, 85, 90, Float(-UIApplication.shared.windowSize.height)]
		)
	}
}

// MARK: - Constants and helpers

private extension ClearNightWeatherView {
	enum Constants {
		static let starShineAnimationKey = "shine"
		static let starsCount = 30
		static let crescentMoonRotationAngle: CGFloat = .pi / 6
		static let moonSize = UIApplication.shared.windowSize.width / 1.5
	}

	func getRandomStarFrame(starSize: Int) -> CGRect {
		CGRect(
			x: Int.random(in: 0...Int(UIApplication.shared.windowSize.width)),
			y: Int.random(in: 0...Int(UIApplication.shared.windowSize.height)),
			width: starSize,
			height: starSize
		)
	}

	func getRandomStarAngle() -> CGFloat {
		.random(in: -CGFloat.pi / 9...CGFloat.pi / 9)
	}
}
