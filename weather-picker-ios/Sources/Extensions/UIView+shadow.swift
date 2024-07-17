//
//  UIView+shadow.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

extension UIView {
	func addShadow(offset: CGSize,
				   radius: CGFloat,
				   color: UIColor = AppColors.blueGray.withAlphaComponent(0.15),
				   opacity: Float = 1) {
		layer.shadowOffset = offset
		layer.shadowRadius = radius
		layer.shadowColor = color.cgColor
		layer.shadowOpacity = opacity
	}
}

