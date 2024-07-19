//
//  FoggyRoadView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 18.07.2024.
//

import UIKit

final class FoggyRoadView: UIView {
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
		fogGradient.frame = bounds
		layer.mask = fogGradient
	}

	// MARK: - Private

	private let fogGradient = CAGradientLayer.AppGradients.fogGradient
	private let roadView: ViewAnimatable = RoadView()

	private func setup() {
		backgroundColor = .clear
		fogGradient.opacity = 0

		setupRoadView()
	}

	private func setupRoadView() {
		addSubview(roadView)

		roadView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}

// MARK: - ViewAnimatable

extension FoggyRoadView: ViewAnimatable {
	func startAnimation(completion: @escaping (() -> Void)) {
		roadView.startAnimation {}
		fogGradient.add(fogGradientOpacityStartAnimation, forKey: UUID().uuidString)
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		fogGradient.add(
			fogGradientOpacityStartAnimation.updated(
				toValue: 0,
				shouldRemove: false
			),
			forKey: UUID().uuidString
		)
	}
}

// MARK: - Animations

private extension FoggyRoadView {
	var fogGradientOpacityStartAnimation: CABasicAnimation {
		CABasicAnimation.makeAnimation(
			keyPath: .opacity,
			duration: 1,
			toValue: 1,
			repeatCount: 1,
			shouldRemove: false
		)
	}
}
