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

	func nearestToEdge(withOffset offset: CGFloat) -> CGPoint {
		let screenSize = UIApplication.shared.windowSize
		var resultX: CGFloat
		var resultY: CGFloat

		if (-offset...offset).contains(x) {
			resultX = 0
		} else if (screenSize.width - offset...screenSize.width + offset).contains(x) {
			resultX = screenSize.width
		} else {
			resultX = x
		}

		if (-offset...offset).contains(y) {
			resultY = 0
		} else if (screenSize.height - offset...screenSize.height + offset).contains(x) {
			resultY = screenSize.height
		} else {
			resultY = y
		}

		if (screenSize.width - offset...screenSize.width + offset).contains(x) {
			resultX = screenSize.width
		}

		if (screenSize.height - offset...screenSize.height + offset).contains(y) {
			resultY = screenSize.height
		}

		return CGPoint(x: resultX, y: resultY)
	}

	func pointOnDifferentEdge() -> CGPoint {

		let screenSize = UIApplication.shared.windowSize

		// Determine which edge the point is on
		if x == 0 {
			// Point is on the left edge, return a point on top, right, or bottom edge
			let edge = Int.random(in: 0...2)
			switch edge {
			case 0:
				return CGPoint(x: CGFloat.random(in: 0...screenSize.width), y: 0)
			case 1:
				return CGPoint(x: screenSize.width, y: CGFloat.random(in: 0...screenSize.height))
			default:
				return CGPoint(x: CGFloat.random(in: 0...screenSize.width), y: screenSize.height)
			}
		} else if x == screenSize.width {
			// Point is on the right edge, return a point on top, left, or bottom edge
			let edge = Int.random(in: 0...2)
			switch edge {
			case 0:
				return CGPoint(x: CGFloat.random(in: 0...screenSize.width), y: 0)
			case 1:
				return CGPoint(x: 0, y: CGFloat.random(in: 0...screenSize.height))
			default:
				return CGPoint(x: CGFloat.random(in: 0...screenSize.width), y: screenSize.height)
			}
		} else if y == 0 {
			// Point is on the top edge, return a point on left, right, or bottom edge
			let edge = Int.random(in: 0...2)
			switch edge {
			case 0:
				return CGPoint(x: 0, y: CGFloat.random(in: 0...screenSize.height))
			case 1:
				return CGPoint(x: screenSize.width, y: CGFloat.random(in: 0...screenSize.height))
			default:
				return CGPoint(x: CGFloat.random(in: 0...screenSize.width), y: screenSize.height)
			}
		} else {
			// Point is on the bottom edge, return a point on left, right, or top edge
			let edge = Int.random(in: 0...2)
			switch edge {
			case 0:
				return CGPoint(x: 0, y: CGFloat.random(in: 0...screenSize.height))
			case 1:
				return CGPoint(x: screenSize.width, y: CGFloat.random(in: 0...screenSize.height))
			default:
				return CGPoint(x: CGFloat.random(in: 0...screenSize.width), y: 0)
			}
		}
	}

}

