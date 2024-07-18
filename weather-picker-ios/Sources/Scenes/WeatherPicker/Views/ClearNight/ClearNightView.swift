//
//  ClearNightView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

final class ClearNightView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private

	private let crescentMoonView = CrescentMoonView()
	private var starViews: [ViewAnimatable] = []

	private let starsCount = 30

	private func setup() {
		setupCrescentMoonView()
		setupStars()
		startAnimation(completion: {})
	}

	private func setupCrescentMoonView() {
		crescentMoonView.transform = CGAffineTransform(rotationAngle: .pi / 6)

		addSubview(crescentMoonView)

		crescentMoonView.snp.makeConstraints { make in
			make.size.equalTo(UIApplication.shared.windowSize.width / 1.5)
			make.centerX.equalToSuperview().multipliedBy(1.25)
			make.centerY.equalToSuperview().dividedBy(1.5)
		}
	}

	private func setupStars() {
		for _ in 0..<starsCount {
			let randomSize = Int.random(in: 5...20)
            let frame = CGRect(
				x: Int.random(in: 0...Int(UIApplication.shared.windowSize.width)),
				y: Int.random(in: 0...Int(UIApplication.shared.windowSize.height)),
				width: randomSize,
				height: randomSize
			)
			let star = StarView(frame: frame)
			star.transform = CGAffineTransform(rotationAngle: CGFloat([
				Float.pi / 9,
				Float.pi / 6,
				Float.pi / 4,
				Float.pi / 3,
				Float.pi / 2,
				Float.pi,
				Float.pi * 1.25,
				Float.pi * 2,
				Float.pi * 1.75
			].randomElement() ?? 0))
			starViews.append(star)

			addSubview(star)
		}
		bringSubviewToFront(crescentMoonView)
	}
}

// MARK: - ViewAnimatable

extension ClearNightView: ViewAnimatable {
	func startAnimation(completion: @escaping (() -> Void)) {
		crescentMoonView.startAnimation {}
		for star in starViews {
			star.startAnimation {}
		}
	}
	
	func stopAnimation(completion: @escaping (() -> Void)) {
		crescentMoonView.stopAnimation {}
		for star in starViews {
			star.stopAnimation {}
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}
