//
//  Randomizable.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 21.07.2024.
//

import Foundation

protocol Randomizable: Comparable {
	static func random(in range: ClosedRange<Self>) -> Self
}

extension Int: Randomizable {
	static func random(in range: ClosedRange<Int>) -> Int {
		let lowerBound = range.lowerBound
		let upperBound = range.upperBound
		let rangeSize = upperBound - lowerBound + 1
		let randomValue = Int(arc4random_uniform(UInt32(rangeSize)))
		return lowerBound + randomValue
	}
}

extension Double: Randomizable {
	static func random(in range: ClosedRange<Double>) -> Double {
		let difference = range.upperBound - range.lowerBound
		let randomValue = Double(arc4random()) / Double(UInt32.max)
		return range.lowerBound + randomValue * difference
	}
}

extension Float: Randomizable {
	static func random(in range: ClosedRange<Float>) -> Float {
		let difference = range.upperBound - range.lowerBound
		let randomValue = Float(arc4random()) / Float(UInt32.max)
		return range.lowerBound + randomValue * difference
	}
}

extension CGFloat: Randomizable {
	static func random(in range: ClosedRange<CGFloat>) -> CGFloat {
		let difference = range.upperBound - range.lowerBound
		let randomValue = CGFloat(arc4random()) / CGFloat(UInt32.max)
		return range.lowerBound + randomValue * difference
	}
}
