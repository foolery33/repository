//
//  CAGradientLayer+AppGradients.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit

extension CAGradientLayer {
	// MARK: - Public

	enum AppGradients {
		// MARK: - Views

		static var sunGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.View.Sun.sunPrimary.cgColor,
					AppColors.Gradient.View.Sun.sunSecondary.cgColor,
					AppColors.Gradient.View.Sun.sunTertiary.cgColor,
					AppColors.Gradient.View.Sun.sunQuaternary.cgColor,
				],
				type: .radial,
				startPoint: CGPoint(x: -0.3, y: 1),
				endPoint: CGPoint(x: 1, y: 0),
				locations: [0, 0.4, 0.5, 1],
				animated: false
			)
		}

		static var sunRayGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.View.Sun.sunSecondary.cgColor,
					AppColors.Gradient.View.Sun.sunQuaternary.cgColor
				],
				locations: [0, Float(Int.random(in: 20...95)) / 100 as NSNumber, 1],
				animationDuration: .random(in: 4...10)
			)
		}

		static var starGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.View.Moon.moonTertiary.cgColor,
					AppColors.Gradient.View.Moon.moonQuaternary.cgColor
				],
				locations: [0, 0.5, 1],
				animationDuration: .random(in: 3...7)
			)
		}

		static var moonGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.View.Moon.moonPrimary.cgColor,
					AppColors.Gradient.View.Moon.moonSecondary.cgColor,
					AppColors.Gradient.View.Moon.moonTertiary.cgColor
				],
				startPoint: CGPoint(x: 0, y: 1),
				endPoint: CGPoint(x: 1, y: 0),
				animationDuration: 5
			)
		}

		static var cloudGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.View.Cloud.cloudPrimary.cgColor,
					AppColors.Gradient.View.Cloud.cloudSecondary.cgColor,
					AppColors.Gradient.View.Cloud.cloudTertiary.cgColor,
					AppColors.Gradient.View.Cloud.cloudQuaternary.cgColor
				],
				locations: [0, Float(Int.random(in: 30...95)) / 100 as NSNumber, 1],
				animated: true,
				animationDuration: .random(in: 10...15)
			)
		}

		static var fogGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.clear.cgColor,
					AppColors.white.cgColor
				],
				startPoint: CGPoint(x: 0.5, y: 0.15),
				endPoint: CGPoint(x: 0.5, y: 1),
				locations: [0, 0.7, 1],
				animated: false
			)
		}

		static var roadGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.white.withAlphaComponent(0.7).cgColor,
					AppColors.white.withAlphaComponent(0.5).cgColor,
					AppColors.white.withAlphaComponent(0.3).cgColor,
					AppColors.white.withAlphaComponent(0.2).cgColor,
					AppColors.white.withAlphaComponent(0).cgColor,
					AppColors.white.withAlphaComponent(0).cgColor
				],
				startPoint: CGPoint(x: 0, y: 0),
				endPoint: CGPoint(x: 1, y: 0.5),
				animationDuration: 10
			)
		}

		static var raindropGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.View.Raindrop.raindropPrimary.cgColor,
					AppColors.Gradient.View.Raindrop.raindropSecondary.cgColor,
					AppColors.Gradient.View.Raindrop.raindropTertiary.cgColor
				],
				startPoint: CGPoint(x: 0, y: 1),
				endPoint: CGPoint(x: 1, y: 0),
				animationDuration: 1
			)
		}

		static var snowdriftGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.View.Snowdrift.snowdriftPrimary.cgColor,
					AppColors.Gradient.View.Snowdrift.snowdriftSecondary.cgColor,
					AppColors.Gradient.View.Snowdrift.snowdriftTertiary.cgColor
				],
				startPoint: CGPoint(x: 0, y: 1),
				endPoint: CGPoint(x: 1, y: 0),
				animationDuration: 1
			)
		}

		static var raindropDarkGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.View.RaindropDark.raindropDarkPrimary.cgColor,
					AppColors.Gradient.View.RaindropDark.raindropDarkSecondary.cgColor,
					AppColors.Gradient.View.RaindropDark.raindropDarkTertiary.cgColor
				],
				startPoint: CGPoint(x: 0, y: 1),
				endPoint: CGPoint(x: 1, y: 0),
				animationDuration: 1
			)
		}

		static private func makeGradient(
			colors: [CGColor],
			type: CAGradientLayerType = .axial,
			startPoint: CGPoint = CGPoint(x: 0.5, y: 0),
			endPoint: CGPoint = CGPoint(x: 0.5, y: 1),
			locations: [NSNumber]? = nil,
			animated: Bool = true,
			animationDuration: CGFloat = 10
		) -> CAGradientLayer {
			let gradientLayer = CAGradientLayer()

			gradientLayer.colors = colors
			gradientLayer.type = type
			gradientLayer.startPoint = startPoint
			gradientLayer.endPoint = endPoint
			gradientLayer.locations = locations

			if animated {
				gradientLayer.addGradientAnimation(
					colors: colors,
					duration: animationDuration
				)
			}

			return gradientLayer
		}

		// MARK: - Backgrounds

		static var clearWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Background.ClearWeather.clearPrimary.cgColor,
				AppColors.Gradient.Background.ClearWeather.clearSecondary.cgColor,
				AppColors.Gradient.Background.ClearWeather.clearTertiary.cgColor
			])
		}

		static var clearNightWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Background.ClearNightWeather.clearNightPrimary.cgColor,
				AppColors.Gradient.Background.ClearNightWeather.clearNightSecondary.cgColor,
				AppColors.Gradient.Background.ClearNightWeather.clearNightTertiary.cgColor
			])
		}

		static var cloudyWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Background.CloudyWeather.cloudyPrimary.cgColor,
				AppColors.Gradient.Background.CloudyWeather.cloudySecondary.cgColor,
				AppColors.Gradient.Background.CloudyWeather.cloudyTertiary.cgColor
			])
		}

		static var rainyWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Background.RainyWeather.rainyPrimary.cgColor,
				AppColors.Gradient.Background.RainyWeather.rainySecondary.cgColor,
				AppColors.Gradient.Background.RainyWeather.rainyTertiary.cgColor
			])
		}

		static var foggyWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Background.FoggyWeather.foggyPrimary.cgColor,
				AppColors.Gradient.Background.FoggyWeather.foggySecondary.cgColor,
				AppColors.Gradient.Background.FoggyWeather.foggyTertiary.cgColor
			])
		}

		static var snowyWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Background.SnowyWeather.snowyPrimary.cgColor,
				AppColors.Gradient.Background.SnowyWeather.snowyTertiary.cgColor,
				AppColors.Gradient.Background.SnowyWeather.snowySecondary.cgColor,
				AppColors.Gradient.Background.SnowyWeather.snowyTertiary.cgColor
			])
		}

		static var thunderstormWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Background.ThunderstormWeather.thunderstormPrimary.cgColor,
				AppColors.Gradient.Background.ThunderstormWeather.thunderstormSecondary.cgColor,
				AppColors.Gradient.Background.ThunderstormWeather.thunderstormTertiary.cgColor
			])
		}

		static private func makeBackgroundGradient(colors: [CGColor]) -> CAGradientLayer {
			makeGradient(
				colors: colors,
				startPoint: CGPoint(x: 0.9, y: 0),
				endPoint: CGPoint(x: 0.3, y: 1),
				animationDuration: 10
			)
		}
	}

	// MARK: - Private

	private func addGradientAnimation(colors: [CGColor], duration: CGFloat) {
		add(
			CABasicAnimation.makeAnimation(
				keyPath: .colors,
				duration: duration,
				fromValue: colors,
				toValue: Array(colors.reversed()),
				autoreverses: true,
				isCumulative: false
			),
			forKey: UUID().uuidString
		)
	}
}
