//
//  CloudyWeatherView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 18.07.2024.
//

import UIKit

final class CloudyWeatherView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private

	private let cloudCount = 12
	private var cloudViews: [ViewAnimatable] = []

	private func setup() {
		setupCloudViews()
		startAnimation {}
	}

	private func setupCloudViews() {
		let screenSize = UIApplication.shared.windowSize
		for i in 0..<cloudCount {
			let cloudWidth = CGFloat.random(in: 100...screenSize.width / 1.5)
			let cloud = CloudView(
				frame: CGRect(
					x: CGFloat.random(
						in: (i < cloudCount / 2) ? -cloudWidth / 2...screenSize.width / 2 - cloudWidth / 2 : screenSize.width / 2...screenSize.width - cloudWidth / 2
					),
					y: CGFloat.random(in: screenSize.height / 4...screenSize.height - screenSize.height / 4),
					width: cloudWidth,
					height: cloudWidth / 2
				)
			)

			let isMirrored: Bool = .random()
			if isMirrored {
				cloud.transform = CGAffineTransform(scaleX: -1, y: 1)
			}

			addSubview(cloud)
			cloudViews.append(cloud)
		}
	}
}

// MARK: - ViewAnimatable

extension CloudyWeatherView: ViewAnimatable {
	func startAnimation(completion: @escaping (() -> Void)) {
		for cloudView in cloudViews {
			cloudView.startAnimation {}
		}
	}
	
	func stopAnimation(completion: @escaping (() -> Void)) {
		for cloudView in self.cloudViews {
			cloudView.stopAnimation {}
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}
