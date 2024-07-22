//
//  WeatherType.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit

enum WeatherType: CaseIterable {
	case clear, clearNight, cloudy, fog, rain, thunderstorm, snow

	var view: ViewAnimatable {
		switch self {
		case .clear:
			ClearWeatherView()
		case .clearNight:
			ClearNightWeatherView()
		case .cloudy:
			CloudyWeatherView()
		case .fog:
			FoggyWeatherView()
		case .rain:
			RainyWeatherView()
		case .thunderstorm:
			ThunderstormWeatherView()
		case .snow:
			SnowyWeatherView()
		}
	}
	
	var backgroundGradient: CAGradientLayer {
		switch self {
		case .clear:
			CAGradientLayer.AppGradients.clearWeatherBackground
		case .clearNight:
			CAGradientLayer.AppGradients.clearNightWeatherBackground
		case .cloudy:
			CAGradientLayer.AppGradients.cloudyWeatherBackground
		case .rain:
			CAGradientLayer.AppGradients.rainyWeatherBackground
		case .fog:
			CAGradientLayer.AppGradients.foggyWeatherBackground
		case .snow:
			CAGradientLayer.AppGradients.snowyWeatherBackground
		case .thunderstorm:
			CAGradientLayer.AppGradients.thunderstormWeatherBackground
		}
	}

	var text: String {
		switch self {
		case .clear:
			NSLocalizedString("clear", comment: "")
		case .clearNight:
			NSLocalizedString("clearNight", comment: "")
		case .cloudy:
			NSLocalizedString("cloudy", comment: "")
		case .fog:
			NSLocalizedString("fog", comment: "")
		case .rain:
			NSLocalizedString("rain", comment: "")
		case .thunderstorm:
			NSLocalizedString("thunderstorm", comment: "")
		case .snow:
			NSLocalizedString("snow", comment: "")
		}
	}

	var icon: UIImage {
		switch self {
		case .clear:
			AppImages.clear
		case .clearNight:
			AppImages.clearNight
		case .cloudy:
			AppImages.cloudy
		case .fog:
			AppImages.fog
		case .rain:
			AppImages.rain
		case .thunderstorm:
			AppImages.thunderstorm
		case .snow:
			AppImages.snow
		}
	}
}
