//
//  WeatherPickerViewModel.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

final class WeatherPickerViewModel {
	// MARK: - Public

	var weatherType: WeatherType = .clear {
		didSet {
			onWeatherTypeUpdated?(SunView())
		}
	}

	var onWeatherTypeUpdated: ((ViewAnimatable) -> Void)?

	func getWeatherView() -> ViewAnimatable {
		SunView()
	}
}
