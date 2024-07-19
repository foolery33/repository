//
//  CGPath+helpers.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 18.07.2024.
//

import UIKit

enum PathElement {
	case moveToPoint(CGPoint)
	case addLineToPoint(CGPoint)
	case addQuadCurveToPoint(CGPoint, CGPoint)
	case addCurveToPoint(CGPoint, CGPoint, CGPoint)
	case closeSubpath
}

extension CGPath {
	func forEach(_ body: @escaping (PathElement) -> Void) {
		self.applyWithBlock { elementPointer in
			let element = elementPointer.pointee
			switch element.type {
			case .moveToPoint:
				body(.moveToPoint(element.points[0]))
			case .addLineToPoint:
				body(.addLineToPoint(element.points[0]))
			case .addQuadCurveToPoint:
				body(.addQuadCurveToPoint(element.points[0], element.points[1]))
			case .addCurveToPoint:
				body(.addCurveToPoint(element.points[0], element.points[1], element.points[2]))
			case .closeSubpath:
				body(.closeSubpath)
			@unknown default:
				fatalError("Unknown element type")
			}
		}
	}
}
