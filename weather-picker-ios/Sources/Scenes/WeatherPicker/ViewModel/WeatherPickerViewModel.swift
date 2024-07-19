//
//  WeatherPickerViewModel.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

final class WeatherPickerViewModel {
	// MARK: - Public

	var weatherType: WeatherType = .fog {
		didSet {
			onWeatherTypeUpdated?(getWeatherView())
		}
	}

	var onWeatherTypeUpdated: ((ViewAnimatable) -> Void)?

	func getWeatherView() -> ViewAnimatable {
		switch weatherType {
		case .clear:
			return SunView()
		case .clearNight:
			return ClearNightView()
		case .cloudy:
			return CloudyWeatherView()
			//		case .partlyCloudy:
			//			<#code#>
			//		case .cloudyNight:
			//			<#code#>
		case .fog:
			return FogWeatherView()
			//		case .heavyRain:
			//			<#code#>
			//		case .rain:
			//			<#code#>
			//		case .rainNight:
			//			<#code#>
			//		case .thunderstorm:
			//			<#code#>
			//		case .blizzard:
			//			<#code#>
			//		case .snow:
			//			<#code#>
			//		case .wind:
			//			<#code#>
			//		case .hail:
			//			<#code#>
		default:
			return SunView()
		}
	}
}
