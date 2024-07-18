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
		static func makeTwoColorsGradient(firstColor: CGColor, secondColor: CGColor, animated: Bool = false) -> CAGradientLayer {
			let gradientLayer = CAGradientLayer()

			gradientLayer.colors = [firstColor, secondColor]
			gradientLayer.type = .radial
			gradientLayer.startPoint = CGPoint(x: 0.9, y: -0.3)
			gradientLayer.endPoint = CGPoint(x: -0.2, y: 0.9)

			if animated {
				gradientLayer.addGradientAnimation(colors: [firstColor, secondColor], duration: 10)
			}

			return gradientLayer
		}

		static var sunGradient: CAGradientLayer {
			let gradientLayer = CAGradientLayer()
			let colors = [
				AppColors.Gradient.Sun.sunPrimary.cgColor,
				AppColors.Gradient.Sun.sunSecondary.cgColor,
				AppColors.Gradient.Sun.sunTertiary.cgColor,
				AppColors.Gradient.Sun.sunQuaternary.cgColor,
			]
			gradientLayer.type = .radial
			gradientLayer.colors = colors
			gradientLayer.startPoint = CGPoint(x: -0.3, y: 1)
			gradientLayer.endPoint = CGPoint(x: 1, y: 0)
			gradientLayer.locations = [0, 0.4, 0.5, 1]

			return gradientLayer
		}

		static let moonGradient: CAGradientLayer = {
			let gradientLayer = CAGradientLayer()
			let colors = [
				AppColors.Gradient.Moon.moonPrimary.cgColor,
				AppColors.Gradient.Moon.moonSecondary.cgColor,
				AppColors.Gradient.Moon.moonTertiary.cgColor
			]
			gradientLayer.type = .axial
			gradientLayer.colors = colors
			gradientLayer.startPoint = CGPoint(x: 0, y: 1)
			gradientLayer.endPoint = CGPoint(x: 1, y: 0)

			gradientLayer.addGradientAnimation(colors: colors, duration: 5)
			return gradientLayer
		}()

		static var starGradient: CAGradientLayer {
			makeRandomColorsPlacementGradient(colors: [
				AppColors.Gradient.Moon.moonTertiary.cgColor,
				AppColors.Gradient.Moon.moonQuaternary.cgColor
			], animated: true)
		}

		static var cloudGradient: CAGradientLayer {
			makeRandomColorsPlacementGradient(
				colors: [
					AppColors.Gradient.Cloud.cloudPrimary.cgColor,
					AppColors.Gradient.Cloud.cloudSecondary.cgColor,
					AppColors.Gradient.Cloud.cloudTertiary.cgColor,
					AppColors.Gradient.Cloud.cloudQuaternary.cgColor
				],
				animated: true,
				duration: .random(in: 10...30)
			)
		}

		static func makeMultipleColorsGradient(colors: [CGColor], type: CAGradientLayerType = .radial, animated: Bool = false) -> CAGradientLayer {
			let gradientLayer = CAGradientLayer()

			gradientLayer.colors = colors
			gradientLayer.type = type
			gradientLayer.startPoint = CGPoint(x: 0.9, y: 0)
			gradientLayer.endPoint = CGPoint(x: 0.3, y: 1)

			if animated {
				gradientLayer.addGradientAnimation(colors: colors, duration: 10)
			}

			return gradientLayer
		}

		static func makeRandomColorsPlacementGradient(colors: [CGColor], animated: Bool = false, duration: CGFloat = 10) -> CAGradientLayer {
			let gradientLayer = CAGradientLayer()

			gradientLayer.colors = colors
			gradientLayer.type = .axial
			gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
			gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.5)
			let randomFloat: NSNumber = Float(Int.random(in: 30...95)) / 100 as NSNumber
			gradientLayer.locations = [0, randomFloat, 1]

			if animated {
				gradientLayer.addGradientAnimation(colors: colors, duration: duration)
			}

			return gradientLayer
		}
	}

	// MARK: - Private

	private func addGradientAnimation(colors: [CGColor], duration: CGFloat) {
		add(CABasicAnimation.makeGradientAnimation(colors: colors, duration: duration), forKey: nil)
	}
}
