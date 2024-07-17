//
//  WeatherType.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit

enum WeatherType: CaseIterable {
	case clear, clearNight, cloudy, partlyCloudy, cloudyNight, fog, heavyRain, rain, rainNight, thunderstorm, blizzard, snow, wind, hail

	var backgroundGradient: CAGradientLayer {
		switch self {
		case .clear:
			CAGradientLayer.AppGradients.makeMultipleColorsGradient(
				colors: [
					AppColors.Gradient.Clear.clearPrimary.cgColor,
					AppColors.Gradient.Clear.clearSecondary.cgColor,
					AppColors.Gradient.Clear.clearTertiary.cgColor
				],
				type: .axial,
				animated: true
			)
//		case .clearNight:
//
//		case .hot:
//			<#code#>
//		case .windy:
//			<#code#>
//		case .rainy:
//			<#code#>
//		case .rainbow:
//			<#code#>
//		case .fog:
//			<#code#>
//		case .cloudy:
//			<#code#>
//		case .snow:
//			<#code#>
//		case .hail:
//			<#code#>
//		case .thunderstorm:
//			<#code#>
		default:
			CAGradientLayer.AppGradients.makeTwoColorsGradient(
				firstColor: AppColors.Gradient.Clear.clearPrimary.cgColor,
				secondColor: AppColors.Gradient.Clear.clearSecondary.cgColor
			)
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
		case .partlyCloudy:
			NSLocalizedString("partlyCloudy", comment: "")
		case .cloudyNight:
			NSLocalizedString("cloudyNight", comment: "")
		case .fog:
			NSLocalizedString("fog", comment: "")
		case .heavyRain:
			NSLocalizedString("heavyRain", comment: "")
		case .rain:
			NSLocalizedString("rain", comment: "")
		case .rainNight:
			NSLocalizedString("rainNight", comment: "")
		case .thunderstorm:
			NSLocalizedString("thunderstorm", comment: "")
		case .blizzard:
			NSLocalizedString("blizzard", comment: "")
		case .snow:
			NSLocalizedString("snow", comment: "")
		case .wind:
			NSLocalizedString("wind", comment: "")
		case .hail:
			NSLocalizedString("hail", comment: "")
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
		case .partlyCloudy:
			AppImages.partlyCloudy
		case .cloudyNight:
			AppImages.cloudyNight
		case .fog:
			AppImages.fog
		case .heavyRain:
			AppImages.heavyRain
		case .rain:
			AppImages.rain
		case .rainNight:
			AppImages.rainNight
		case .thunderstorm:
			AppImages.thunderstorm
		case .blizzard:
			AppImages.blizzard
		case .snow:
			AppImages.snow
		case .wind:
			AppImages.wind
		case .hail:
			AppImages.hail
		}
	}
}
