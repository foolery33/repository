//
//  FoggyWeatherView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 18.07.2024.
//

import UIKit

final class FoggyWeatherView: UIView {
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
		fogGradient.frame = bounds
		layer.mask = fogGradient
	}

	// MARK: - Private

	private let fogGradient = CAGradientLayer.AppGradients.fogGradient
	private let roadView = BaseDrawableView(drawingType: .road)

	private func setup() {
		fogGradient.opacity = 0

		setupRoadView()
		setupGradients()
		setupAnimations()
		startAnimation()
	}

	private func setupRoadView() {
		addSubview(roadView)

		roadView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			roadView.topAnchor.constraint(equalTo: topAnchor),
			roadView.bottomAnchor.constraint(equalTo: bottomAnchor),
			roadView.leadingAnchor.constraint(equalTo: leadingAnchor),
			roadView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}

	private func setupGradients() {
		roadView.addGradient(CAGradientLayer.AppGradients.roadGradient)
	}

	private func setupAnimations() {
		roadView.setAnimations(
			startAnimations: [(roadGradientOpacityStartAnimation, UUID().uuidString)],
			stopAnimations: [(roadGradientOpacityStopAnimation, UUID().uuidString)]
		)
	}
}

// MARK: - ViewAnimatable

extension FoggyWeatherView: ViewAnimatable {
	func startAnimation() {
		fogGradient.add(fogGradientOpacityStartAnimation, forKey: UUID().uuidString)
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		fogGradient.add(
			fogGradientOpacityStartAnimation.updated(
				toValue: 0
			),
			forKey: UUID().uuidString
		)

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}

// MARK: - Animations

private extension FoggyWeatherView {
	// Fog

	var fogGradientOpacityStartAnimation: CABasicAnimation {
		CABasicAnimation.makeAnimation(
			keyPath: .opacity,
			duration: 1,
			toValue: 1,
			repeatCount: 1
		)
	}

	// Road

	var roadGradientOpacityStartAnimation: CABasicAnimation {
		CABasicAnimation.makeAnimation(
			keyPath: .opacity,
			duration: 4,
			toValue: 1,
			repeatCount: 1
		)
	}

	var roadGradientOpacityStopAnimation: CABasicAnimation {
		roadGradientOpacityStartAnimation.updated(
			toValue: 0
		)
	}
}
