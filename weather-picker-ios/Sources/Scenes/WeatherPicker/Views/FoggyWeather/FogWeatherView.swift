//
//  FogWeatherView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 18.07.2024.
//

import UIKit

final class FogWeatherView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private

	private let foggyRoadView = FoggyRoadView()

	private func setup() {
		setupFoggyRoadView()
		startAnimation {}
	}

	private func setupFoggyRoadView() {
		addSubview(foggyRoadView)

		foggyRoadView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}

// MARK: - ViewAnimatable

extension FogWeatherView: ViewAnimatable {
	func startAnimation(completion: @escaping (() -> Void)) {
		foggyRoadView.startAnimation {}
	}
	
	func stopAnimation(completion: @escaping (() -> Void)) {
		foggyRoadView.stopAnimation {}
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}
