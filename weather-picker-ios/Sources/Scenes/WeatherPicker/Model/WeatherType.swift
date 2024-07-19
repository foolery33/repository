//
//  WeatherType.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit

enum WeatherType: CaseIterable {
	case clear, clearNight, cloudy, fog, rain, thunderstorm, snow

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
		case .clearNight:
			CAGradientLayer.AppGradients.makeMultipleColorsGradient(
				colors: [
					AppColors.Gradient.Night.nightPrimary.cgColor,
					AppColors.Gradient.Night.nightSecondary.cgColor,
					AppColors.Gradient.Night.nightTertiary.cgColor
				], type: .axial
				, animated: true
			)
		case .cloudy:
			CAGradientLayer.AppGradients.makeMultipleColorsGradient(
				colors: [
					AppColors.Gradient.Cloudy.cloudyPrimary.cgColor,
					AppColors.Gradient.Cloudy.cloudySecondary.cgColor,
					AppColors.Gradient.Cloudy.cloudyTertiary.cgColor
				],
				type: .axial,
				animated: true
			)
//		case .hot:
//			<#code#>
//		case .windy:
//			<#code#>
		case .rain:
			CAGradientLayer.AppGradients.makeMultipleColorsGradient(
				colors: [
					AppColors.Gradient.Rainy.rainyPrimary.cgColor,
					AppColors.Gradient.Rainy.rainySecondary.cgColor,
					AppColors.Gradient.Rainy.rainyTertiary.cgColor
				],
				type: .axial,
				animated: true
			)
//		case .rainbow:
//			<#code#>
		case .fog:
			CAGradientLayer.AppGradients.makeMultipleColorsGradient(
				colors: [
					AppColors.Gradient.Foggy.foggyPrimary.cgColor,
					AppColors.Gradient.Foggy.foggySecondary.cgColor,
					AppColors.Gradient.Foggy.foggyTertiary.cgColor
				],
				type: .axial,
				animated: true
			)
//		case .cloudy:
//			<#code#>
		case .snow:
			CAGradientLayer.AppGradients.makeMultipleColorsGradient(
				colors: [
					AppColors.Gradient.Snowy.snowyPrimary.cgColor,
					AppColors.Gradient.Snowy.snowyTertiary.cgColor,
					AppColors.Gradient.Snowy.snowySecondary.cgColor,
					AppColors.Gradient.Snowy.snowyTertiary.cgColor
				],
				type: .axial,
				animated: true
			)
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
