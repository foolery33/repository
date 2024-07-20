//
//  WeatherPickerViewModel.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

final class WeatherPickerViewModel {
	// MARK: - Init

	init(weatherType: WeatherType) {
		self.weatherType = weatherType
	}

	// MARK: - Public

	var weatherType: WeatherType {
		didSet {
			onWeatherTypeUpdated?(weatherType.view)
		}
	}

	var onWeatherTypeUpdated: ((ViewAnimatable) -> Void)?
}
