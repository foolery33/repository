//
//  ThunderstormWeatherView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 21.07.2024.
//

import UIKit

final class ThunderstormWeatherView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private

	private var lightningViews: [BaseDrawableView] = []
	private var raindropViews: [BaseDrawableView] = []

	private var scheduledLightningWorkItems: [DispatchWorkItem] = []

	private func setup() {
		setupRaindropViews()
		setupLightningViews()
		setupGradients()
		setupAnimations()
		startAnimation()
	}

	private func setupRaindropViews() {
		for _ in 0..<Constants.raindropCount {
			let raindrop = BaseDrawableView(
				drawingType: Bool.random() == true ? .raindropFirst : .raindropSecond,
				frame: getRandomRaindropFrame()
			)
			raindrop.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -.pi / 20...CGFloat.pi / 20))

			addSubview(raindrop)
			raindropViews.append(raindrop)
		}
	}

	private func setupLightningViews() {
		for i in 0..<Constants.lightningCount {
			let lightning = BaseDrawableView(
				drawingType: .lightning,
				frame: getRandomLightningFrame()
			)
			lightningViews.append(lightning)
			lightning.transform = CGAffineTransform(rotationAngle: .random(in: -Double.pi / 4...Double.pi / 4))
			lightning.onPathReceived = { [weak self] cgPath in
				guard let self else { return }
				let shapeAnimationLayer = self.getLightningShapeAnimationLayer(path: cgPath)
				lightning.shapeLayer = shapeAnimationLayer

				let opacityAnimation = lightningOpacityAnimation
				opacityAnimation.delegate = self
				opacityAnimation.setValue(i, forKey: Constants.lightningRepeatAnimationKey)

				let workItem = DispatchWorkItem {
					shapeAnimationLayer.add(self.lightningStrokeAnimation, forKey: UUID().uuidString)
					lightning.layer.add(opacityAnimation, forKey: UUID().uuidString)
					lightning.layer.addSublayer(shapeAnimationLayer)
				}
				DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...5), execute: workItem)
				scheduledLightningWorkItems.append(workItem)
			}
			addSubview(lightning)
		}
	}

	private func setupGradients() {
		for raindropView in raindropViews {
			raindropView.addGradient(CAGradientLayer.AppGradients.raindropDarkGradient)
		}
	}

	private func setupAnimations() {
		for raindropView in raindropViews {
			raindropView.setAnimations(
				stopAnimations: [
					(raindropStopPositionXAnimation(
						direction: raindropView.frame.midX > UIApplication.shared.windowSize.width / 2 ? true : false
					), UUID().uuidString)
				]
			)

			raindropView.setDelayedAnimation(
				(raindropMovingAnimation(
					xOffset: Float(calculateFinalX(
						startPoint: raindropView.frame.origin,
						angle: .pi / 2 - raindropView.rotationAngleInRadians,
						finalY: UIApplication.shared.windowSize.height
					)),
					raindropHeight: raindropView.bounds.height,
					direction: raindropView.rotationAngleInRadians < 0
				), UUID().uuidString),
				delay: Double.random(in: 1...5)
			)
		}
	}

	private func getLightningShapeAnimationLayer(path: CGPath) -> CAShapeLayer {
		let shapeLayer = CAShapeLayer()

		shapeLayer.path = path
		shapeLayer.strokeColor = AppColors.white.cgColor
		shapeLayer.fillColor = AppColors.clear.cgColor
		shapeLayer.lineWidth = 3
		shapeLayer.shadowColor = AppColors.white.cgColor
		shapeLayer.shadowOpacity = 1
		shapeLayer.shadowRadius = 20

		return shapeLayer
	}
}

// MARK: - ViewAnimatable

extension ThunderstormWeatherView: ViewAnimatable {
	func startAnimation() {
		for raindropView in raindropViews {
			raindropView.startAnimation()
		}

		for lightningView in lightningViews {
			lightningView.startAnimation()
		}
	}
	
	func stopAnimation(completion: @escaping (() -> Void)) {
		for raindropView in raindropViews {
			raindropView.stopAnimation {}
		}

		for lightningView in lightningViews {
			for workItem in scheduledLightningWorkItems {
				workItem.cancel()
			}
			scheduledLightningWorkItems.removeAll()
			lightningView.stopAnimation {}
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}

// MARK: - CAAnimationDelegate

extension ThunderstormWeatherView: CAAnimationDelegate {
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		if flag, let lightningViewIndex = anim.value(forKey: Constants.lightningRepeatAnimationKey) as? Int {
			guard let shapeAnimationLayer = lightningViews[lightningViewIndex].shapeLayer else { return }

			let opacityAnimation = lightningOpacityAnimation
			opacityAnimation.delegate = self
			opacityAnimation.setValue(lightningViewIndex, forKey: Constants.lightningRepeatAnimationKey)

			let workItem = DispatchWorkItem {
				shapeAnimationLayer.add(self.lightningStrokeAnimation, forKey: UUID().uuidString)
				self.lightningViews[lightningViewIndex].layer.add(opacityAnimation, forKey: UUID().uuidString)
			}
			DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1...7), execute: workItem)
			scheduledLightningWorkItems.append(workItem)
		}
	}
}

// MARK: - Animations

private extension ThunderstormWeatherView {
	// Lightning

	var lightningStrokeAnimation: CABasicAnimation {
		CABasicAnimation.makeAnimation(
			keyPath: .strokeEnd,
			duration: 0.3,
			fromValue: 0,
			toValue: 1,
			shouldRemove: true
		)
	}

	var lightningOpacityAnimation: CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .opacity,
			duration: .random(in: 1...2),
			isAdditive: false,
			values: [1, 1, 0],
			repeatCount: 1
		)
	}

	var lightningStopOpacityAnimation: CAKeyframeAnimation {
		lightningOpacityAnimation.updated(duration: 1, isAdditive: false, values: [0])
	}

	// Raindrop

	func raindropMovingAnimation(xOffset: Float, raindropHeight: Double, direction: Bool) -> CAAnimationGroup {
		let group = CAAnimationGroup()
		let duration: CGFloat = .random(in: 0.3...0.9)
		group.duration = duration
		group.animations = [raindropPositionYAnimation(raindropHeight: raindropHeight, duration: duration), raindropPositionXAnimation(xOffset: xOffset, direction: direction, duration: duration)]
		group.isRemovedOnCompletion = false
		group.fillMode = .forwards
		group.repeatCount = .infinity
		return group
	}

	func raindropPositionYAnimation(raindropHeight: Double, duration: CGFloat) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionY,
			duration: duration,
			values: [0, Float(UIApplication.shared.windowSize.height + raindropHeight)]
		)
	}

	func raindropPositionXAnimation(xOffset: Float, direction: Bool, duration: CGFloat) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: duration,
			direction: direction,
			values: [0, xOffset]
		)
	}

	func raindropStopPositionXAnimation(direction: Bool) -> CAKeyframeAnimation {
		CAKeyframeAnimation.makeAnimation(
			keyPath: .positionX,
			duration: 1,
			direction: direction,
			values: [0, Float(UIApplication.shared.windowSize.width)],
			repeatCount: 1
		)
	}
}

// MARK: - Constants and helpers

private extension ThunderstormWeatherView {
	enum Constants {
		static let lightningCount = 7
		static let raindropCount = 100
		static let lightningRepeatAnimationKey = "lightning"
	}

	func getRandomLightningFrame() -> CGRect {
		let screenSize = UIApplication.shared.windowSize
		return CGRect(
			x: .random(in: 0...screenSize.width),
			y: .random(in: -screenSize.height * 0.2...screenSize.height * 0.4),
			width: .random(in: 30...120),
			height: .random(in: screenSize.height * 0.3...screenSize.height * 0.7)
		)
	}

	func getRandomRaindropFrame() -> CGRect {
		let raindropHeight = Double.random(in: 10...30)
		return CGRect(
			origin: CGPoint(
				x: .random(in: 0...UIApplication.shared.windowSize.width),
				y: -raindropHeight
			),
			size: CGSize(width: raindropHeight / 4, height: raindropHeight)
		)
	}

	func calculateFinalX(startPoint: CGPoint, angle: CGFloat, finalY: CGFloat) -> CGFloat {
		let dx = finalY / tan(angle)

		return angle < .pi / 2 ? dx : -dx
	}
}
