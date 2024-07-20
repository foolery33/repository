//
//  RainyWeatherView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 19.07.2024.
//

import UIKit

final class RainyWeatherView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private

	private var cloudViews: [BaseDrawableView] = []
	private var raindropViews: [BaseDrawableView] = []

	private func setup() {
		setupRaindropViews()
		setupCloudViews()
		setupGradients()
		setupAnimations()
		startAnimation()
	}

	private func setupCloudViews() {
		let screenSize = UIApplication.shared.windowSize
		let biggestCloudsXPositions: [CGFloat] = [-screenSize.width * 0.2, screenSize.width / 2 * 0.4, screenSize.width * 0.7]
		for i in 0..<Constants.cloudCount {
			let cloudWidth = UIApplication.shared.windowSize.width * CGFloat.random(in: 0.8...1)
			let xPosition = (i < 3) ? biggestCloudsXPositions[i] : .random(in: -cloudWidth / 2...screenSize.width / 2)
			let cloud = BaseDrawableView(
				drawingType: .cloud,
				frame: CGRect(
					x: xPosition,
					y: screenSize.height * 0.07,
					width: cloudWidth,
					height: cloudWidth / 2
				)
			)
			cloud.addShadow(offset: .init(width: 0, height: 0), radius: 10, color: AppColors.Gradient.Rainy.rainyTertiary, opacity: 1)

			let isMirrored: Bool = .random()
			if isMirrored {
				cloud.transform = CGAffineTransform(scaleX: -1, y: 1)
			}

			addSubview(cloud)
			cloudViews.append(cloud)
		}
	}

	private func setupRaindropViews() {
		let screenSize = UIApplication.shared.windowSize
		for _ in 0..<Constants.raindropCount {
			let raindropHeight = Double.random(in: 10...40)
			let raindrop = BaseDrawableView(
				drawingType: Bool.random() == true ? .raindropFirst : .raindropSecond,
				frame: CGRect(
					origin: CGPoint(
						x: .random(in: 0...screenSize.width),
						y: screenSize.height * 0.2
					),
					size: CGSize(width: raindropHeight / 4, height: raindropHeight)
				)
			)
			raindrop.layer.opacity = 0
			raindrop.transform = CGAffineTransform(rotationAngle: .random(in: -.pi / 18...CGFloat.pi / 18))

			addSubview(raindrop)
			raindropViews.append(raindrop)
		}
	}

	private func setupGradients() {
		for cloudView in cloudViews {
			cloudView.addGradient(CAGradientLayer.AppGradients.cloudGradient)
		}

		for raindropView in raindropViews {
			raindropView.addGradient(CAGradientLayer.AppGradients.raindropGradient)
		}
	}

	private func setupAnimations() {
		for cloudView in cloudViews {
			cloudView.setAnimations(
				startAnimations: [
					(cloudStartScaleAnimation, UUID().uuidString),
					(cloudStartPositionXAnimation(frame: cloudView.frame), UUID().uuidString),
					(cloudPositionXAnimation(frame: cloudView.frame), UUID().uuidString),
					(cloudPositionYAnimation, UUID().uuidString)
				],
				stopAnimations: [
					(cloudStopScaleAnimation, UUID().uuidString),
					(cloudStopPositionXAnimation(frame: cloudView.frame), UUID().uuidString)
				]
			)
		}

		for raindropView in raindropViews {
			raindropView.setAnimations(
				startAnimations: [(raindropStartOpacityAnimation, UUID().uuidString)],
				stopAnimations: [(raindropStopOpacityAnimation, UUID().uuidString)]
			)

			raindropView.setDelayedAnimation(
				(raindropStartMovingAnimation(
					xOffset: abs(Float(raindropView.frame.midX) - Float(calculateFinalX(
						startPoint: raindropView.frame.origin,
						angle: raindropView.rotationAngleInRadians,
						finalY: UIApplication.shared.windowSize.height + raindropView.bounds.height
					))),
					raindropHeight: raindropView.bounds.height,
					clockwise: raindropView.rotationAngleInRadians < 0
				), UUID().uuidString),
				delay: Double.random(in: 0...5)
			)
		}
	}

	private func calculateFinalX(startPoint: CGPoint, angle: CGFloat, finalY: CGFloat) -> CGFloat {
		return startPoint.y + finalY * sin(angle)
	}

	private func isForwardCloudAnimationDirection(frame: CGRect) -> Bool {
		frame.minX < UIApplication.shared.windowSize.width / 2 ? true : false
	}
}

// MARK: - ViewAnimatable

extension RainyWeatherView: ViewAnimatable {
	func startAnimation() {
		for cloudView in cloudViews {
			cloudView.startAnimation()
		}
		for raindropView in raindropViews {
			raindropView.startAnimation()
		}
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		for cloudView in cloudViews {
			cloudView.stopAnimation {
				completion()
			}
		}
		for raindropView in raindropViews {
			raindropView.stopAnimation {
				completion()
			}
		}
	}
}

// MARK: - Animations

private extension RainyWeatherView {
	// Raindrop

	var raindropStartOpacityAnimation: CABasicAnimation {
		CABasicAnimation.makeAnimation(
			keyPath: .opacity,
			duration: 3,
			toValue: 1,
			repeatCount: 1
		)
	}

	func raindropStartMovingAnimation(xOffset: Float, raindropHeight: Double, clockwise: Bool) -> CAAnimationGroup {
		let group = CAAnimationGroup()
		let duration: CGFloat = .random(in: 0.3...1.5)
		group.duration = duration
		group.animations = [raindropStartPositionYAnimation(raindropHeight: raindropHeight, duration: duration), raindropStartPositionXAnimation(xOffset: xOffset, clockwise: clockwise, duration: duration)]
		group.isRemovedOnCompletion = false
		group.fillMode = .forwards
		group.repeatCount = .infinity
		return group
	}

	func raindropStartPositionYAnimation(raindropHeight: Double, duration: CGFloat) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: duration,
			values: [0, Float(UIApplication.shared.windowSize.height + raindropHeight)]
		)
	}

	func raindropStartPositionXAnimation(xOffset: Float, clockwise: Bool, duration: CGFloat) -> CAKeyframeAnimation {
		return CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: duration,
			clockwise: clockwise,
			values: [0, xOffset]
		)
	}

	var raindropStopOpacityAnimation: CAAnimation {
		raindropStartOpacityAnimation.updated(
			duration: 0.5,
			toValue: 0
		)
	}

	// MARK: - Cloud

	var cloudPositionYAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: .random(in: 60...100),
			clockwise: .random(),
			values: [0, 10, 0, -10, 0]
		)
	}

	var cloudStartScaleAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .transformScale,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			clockwise: transform.isIdentity,
			values: [-0.4, 0, 0.15, 0],
			repeatCount: 1
		)
	}

	var cloudStopScaleAnimation: CAKeyframeAnimation {
		cloudStartScaleAnimation.updated(
			clockwise: transform.isIdentity,
			values: [0, -0.4]
		)
	}

	func cloudStartPositionXAnimation(frame: CGRect) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: 1,
			timingFunction: CAMediaTimingFunction(name: .easeOut),
			clockwise: isForwardCloudAnimationDirection(frame: frame),
			values: [Float(-UIApplication.shared.windowSize.width), -300, -200, -100, -50, -30, -20, -10, -5, 0],
			repeatCount: 1
		)
	}

	func cloudPositionXAnimation(frame: CGRect) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: .random(in: 100...200),
			clockwise: isForwardCloudAnimationDirection(frame: frame),
			values: [0, 40, 0]
		)
	}

	func cloudStopPositionXAnimation(frame: CGRect) -> CAKeyframeAnimation {
		cloudStartPositionXAnimation(frame: frame).updated(
			timingFunction: CAMediaTimingFunction(name: .easeInEaseOut),
			clockwise: .random(),
			values: [Float(-UIApplication.shared.windowSize.width - frame.size.width), -300, -200, -100, -50, -30, -20, -10, -5, 0].reversed()
		)
	}
}

// MARK: - Constants

private extension RainyWeatherView {
	enum Constants {
		static let cloudCount = 5
		static let raindropCount = 100
	}
}
