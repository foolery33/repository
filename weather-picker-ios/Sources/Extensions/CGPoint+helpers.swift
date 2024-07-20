//
//  CGPoint+helpers.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 20.07.2024.
//

import UIKit

extension CGPoint {
	static func randomTopPoint(withOffset offset: CGFloat) -> CGPoint {
		let screenSize = UIApplication.shared.windowSize

		let y = -offset
		let x = CGFloat.random(in: offset * 1.5...screenSize.width)
		return CGPoint(x: x, y: y)
	}
}
