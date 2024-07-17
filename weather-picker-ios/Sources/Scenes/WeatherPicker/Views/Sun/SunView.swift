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
		startAnimation() {

		}
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
		sunView.layer.add(CABasicAnimation.makeRotationAnimation(duration: 60), forKey: nil)
		layer.add(CABasicAnimation.makeRotationAnimation(clockwise: false , duration: 180), forKey: nil)

		let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
		rotationAnimation.values = [0, Float.pi / 4, Float.pi / 2, Float.pi * 0.75, Float.pi, Float.pi * 1.25, Float.pi * 2, Float.pi * 4, Float.pi * 8].reversed()
		rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		rotationAnimation.duration = 1
		rotationAnimation.isAdditive = true

		let positionYAnimation = CAKeyframeAnimation(keyPath: "position.y")
		positionYAnimation.values = [0, -80, -120, 120, -1000].reversed()
		positionYAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
		positionYAnimation.duration = 1
		positionYAnimation.isAdditive = true

		let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
		scaleAnimation.values = [0, 0.5, 0.6, -0.1, -1].reversed()
		scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
		scaleAnimation.duration = 1
		scaleAnimation.isAdditive = true

		layer.add(rotationAnimation, forKey: AnimationKeys.rotation)
		layer.add(positionYAnimation, forKey: AnimationKeys.positionY)
		layer.add(scaleAnimation, forKey: AnimationKeys.transformScale)
	}
	func stopAnimation(completion: @escaping (() -> Void)) {
		let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
		rotationAnimation.values = [0, Float.pi / 4, Float.pi / 2, Float.pi * 0.75, Float.pi, Float.pi * 1.25, Float.pi * 2, Float.pi * 4, Float.pi * 8]
		rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		rotationAnimation.duration = 1
		rotationAnimation.isAdditive = true

		let positionYAnimation = CAKeyframeAnimation(keyPath: "position.y")
		positionYAnimation.values = [0, -80, -120, 120, -1000]
		positionYAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
		positionYAnimation.duration = 1
		positionYAnimation.isAdditive = true
		positionYAnimation.isRemovedOnCompletion = false
		positionYAnimation.fillMode = .forwards

		let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
		scaleAnimation.values = [0, 0.5, 0.6, -0.1, -1]
		scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
		scaleAnimation.duration = 1
		scaleAnimation.isAdditive = true

		layer.add(rotationAnimation, forKey: AnimationKeys.rotation)
		layer.add(positionYAnimation, forKey: AnimationKeys.positionY)
		layer.add(scaleAnimation, forKey: AnimationKeys.transformScale)

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}

// MARK: - AnimationKeys

private extension SunView {
	enum AnimationKeys {
		static let rotation = "rotation"
		static let positionY = "positionY"
		static let transformScale = "scale"
	}
}
