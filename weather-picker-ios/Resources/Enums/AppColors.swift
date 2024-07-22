//
//  AppColors.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit

enum AppColors {
	static let clear = UIColor.clear
	static let white = UIColor.white
	static let black = UIColor.black
	static let darkPurple = UIColor.darkPurple
	static let blueGray = UIColor.blueGray
	
	enum Gradient {
		enum Background {
			enum ClearWeather {
				static let clearPrimary = UIColor.clearPrimary
				static let clearSecondary = UIColor.clearSecondary
				static let clearTertiary = UIColor.clearTertiary
			}

			enum ClearNightWeather {
				static let clearNightPrimary = UIColor.clearNightPrimary
				static let clearNightSecondary = UIColor.clearNightSecondary
				static let clearNightTertiary = UIColor.clearNightTertiary
			}

			enum CloudyWeather {
				static let cloudyPrimary = UIColor.cloudyPrimary
				static let cloudySecondary = UIColor.cloudySecondary
				static let cloudyTertiary = UIColor.cloudyTertiary
			}

			enum FoggyWeather {
				static let foggyPrimary = UIColor.foggyPrimary
				static let foggySecondary = UIColor.foggySecondary
				static let foggyTertiary = UIColor.foggyTertiary
			}

			enum RainyWeather {
				static let rainyPrimary = UIColor.rainyPrimary
				static let rainySecondary = UIColor.rainySecondary
				static let rainyTertiary = UIColor.rainyTertiary
			}

			enum SnowyWeather {
				static let snowyPrimary = UIColor.snowyPrimary
				static let snowySecondary = UIColor.snowySecondary
				static let snowyTertiary = UIColor.snowyTertiary
			}

			enum ThunderstormWeather {
				static let thunderstormPrimary = UIColor.thunderstormPrimary
				static let thunderstormSecondary = UIColor.thunderstormSecondary
				static let thunderstormTertiary = UIColor.thunderstormTertiary
			}
		}

		enum View {
			enum Sun {
				static let sunPrimary = UIColor.sunPrimary
				static let sunSecondary = UIColor.sunSecondary
				static let sunTertiary = UIColor.sunTertiary
				static let sunQuaternary = UIColor.sunQuaternary
			}

			enum Moon {
				static let moonPrimary = UIColor.moonPrimary
				static let moonSecondary = UIColor.moonSecondary
				static let moonTertiary = UIColor.moonTertiary
				static let moonQuaternary = UIColor.moonQuaternary
			}

			enum Cloud {
				static let cloudPrimary = UIColor.cloudPrimary
				static let cloudSecondary = UIColor.cloudSecondary
				static let cloudTertiary = UIColor.cloudTertiary
				static let cloudQuaternary = UIColor.cloudQuaternary
			}

			enum Fog {
				static let fogPrimary = UIColor.fogPrimary
				static let fogSecondary = UIColor.fogSecondary
				static let fogTertiary = UIColor.fogTertiary
				static let fogQuaternary = UIColor.fogQuaternary
			}

			enum Raindrop {
				static let raindropPrimary = UIColor.raindropPrimary
				static let raindropSecondary = UIColor.raindropSecondary
				static let raindropTertiary = UIColor.raindropTertiary
			}

			enum Snowdrift {
				static let snowdriftPrimary = UIColor.snowdriftPrimary
				static let snowdriftSecondary = UIColor.snowdriftSecondary
				static let snowdriftTertiary = UIColor.snowdriftTertiary
			}

			enum RaindropDark {
				static let raindropDarkPrimary = UIColor.raindropDarkPrimary
				static let raindropDarkSecondary = UIColor.raindropDarkSecondary
				static let raindropDarkTertiary = UIColor.raindropDarkTertiary
			}
		}
	}
}
