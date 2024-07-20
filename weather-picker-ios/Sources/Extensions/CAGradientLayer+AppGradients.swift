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
					AppColors.Gradient.Sun.sunPrimary.cgColor,
					AppColors.Gradient.Sun.sunSecondary.cgColor,
					AppColors.Gradient.Sun.sunTertiary.cgColor,
					AppColors.Gradient.Sun.sunQuaternary.cgColor,
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
					AppColors.Gradient.Sun.sunSecondary.cgColor,
					AppColors.Gradient.Sun.sunQuaternary.cgColor
				],
				locations: [0, Float(Int.random(in: 20...95)) / 100 as NSNumber, 1],
				animationDuration: .random(in: 4...10)
			)
		}

		static var starGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.Moon.moonSecondary.cgColor,
					AppColors.Gradient.Moon.moonQuaternary.cgColor
				],
				locations: [0, 0.5, 1],
				animationDuration: .random(in: 3...7)
			)
		}

		static var moonGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.Moon.moonPrimary.cgColor,
					AppColors.Gradient.Moon.moonSecondary.cgColor,
					AppColors.Gradient.Moon.moonTertiary.cgColor
				],
				startPoint: CGPoint(x: 0, y: 1),
				endPoint: CGPoint(x: 1, y: 0),
				animationDuration: 5
			)
		}

		static var cloudGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.Cloud.cloudPrimary.cgColor,
					AppColors.Gradient.Cloud.cloudSecondary.cgColor,
					AppColors.Gradient.Cloud.cloudTertiary.cgColor,
					AppColors.Gradient.Cloud.cloudQuaternary.cgColor
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
					AppColors.Gradient.Raindrop.raindropPrimary.cgColor,
					AppColors.Gradient.Raindrop.raindropSecondary.cgColor,
					AppColors.Gradient.Raindrop.raindropTertiary.cgColor
				],
				startPoint: CGPoint(x: 0, y: 1),
				endPoint: CGPoint(x: 1, y: 0),
				animationDuration: 1
			)
		}

		static var snowdriftGradient: CAGradientLayer {
			makeGradient(
				colors: [
					AppColors.Gradient.Snowdrift.snowdriftPrimary.cgColor,
					AppColors.Gradient.Snowdrift.snowdriftSecondary.cgColor,
					AppColors.Gradient.Snowdrift.snowdriftTertiary.cgColor
				],
				startPoint: CGPoint(x: 0, y: 1),
				endPoint: CGPoint(x: 1, y: 0),
				animationDuration: 1
			)
		}

		static private func makeGradient(
			colors: [CGColor],
			type: CAGradientLayerType = .axial,
			startPoint: CGPoint = .init(x: 0.5, y: 0),
			endPoint: CGPoint = .init(x: 0.5, y: 1),
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
				AppColors.Gradient.Clear.clearPrimary.cgColor,
				AppColors.Gradient.Clear.clearSecondary.cgColor,
				AppColors.Gradient.Clear.clearTertiary.cgColor
			])
		}

		static var clearNightWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Night.nightPrimary.cgColor,
				AppColors.Gradient.Night.nightSecondary.cgColor,
				AppColors.Gradient.Night.nightTertiary.cgColor
			])
		}

		static var cloudyWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Cloudy.cloudyPrimary.cgColor,
				AppColors.Gradient.Cloudy.cloudySecondary.cgColor,
				AppColors.Gradient.Cloudy.cloudyTertiary.cgColor
			])
		}

		static var rainyWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Rainy.rainyPrimary.cgColor,
				AppColors.Gradient.Rainy.rainySecondary.cgColor,
				AppColors.Gradient.Rainy.rainyTertiary.cgColor
			])
		}

		static var foggyWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Foggy.foggyPrimary.cgColor,
				AppColors.Gradient.Foggy.foggySecondary.cgColor,
				AppColors.Gradient.Foggy.foggyTertiary.cgColor
			])
		}

		static var snowyWeatherBackground: CAGradientLayer {
			makeBackgroundGradient(colors: [
				AppColors.Gradient.Snowy.snowyPrimary.cgColor,
				AppColors.Gradient.Snowy.snowyTertiary.cgColor,
				AppColors.Gradient.Snowy.snowySecondary.cgColor,
				AppColors.Gradient.Snowy.snowyTertiary.cgColor
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
