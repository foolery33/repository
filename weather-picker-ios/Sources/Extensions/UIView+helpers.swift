//
//  UIView+helpers.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 19.07.2024.
//

import UIKit

extension UIView {
	var rotationAngleInRadians: CGFloat {
		let transform = self.transform
		return atan2(transform.b, transform.a)
	}

	var rotationAngleInDegrees: CGFloat {
		return rotationAngleInRadians * 180 / .pi
	}
}
