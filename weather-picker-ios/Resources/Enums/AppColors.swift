//
//  AppColors.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit

enum AppColors {
	enum Gradient {
		enum Clear {
			static let clearPrimary = UIColor.clearPrimary
			static let clearSecondary = UIColor.clearSecondary
			static let clearTertiary = UIColor.clearTertiary
		}

		enum Sun {
			static let sunPrimary = UIColor.sunPrimary
			static let sunSecondary = UIColor.sunSecondary
			static let sunTertiary = UIColor.sunTertiary
			static let sunQuaternary = UIColor.sunQuaternary
		}

		enum Night {
			static let nightPrimary = UIColor.nightPrimary
			static let nightSecondary = UIColor.nightSecondary
			static let nightTertiary = UIColor.nightTertiary
		}

		enum Moon {
			static let moonPrimary = UIColor.moonPrimary
			static let moonSecondary = UIColor.moonSecondary
			static let moonTertiary = UIColor.moonTertiary
			static let moonQuaternary = UIColor.moonQuaternary
		}
	}
	static let white = UIColor.white
	static let darkPurple = UIColor.darkPurple
	static let blueGray = UIColor.blueGray
	static let orangeYellow = UIColor.orangeYellow
}
