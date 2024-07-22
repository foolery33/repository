//
//  CGPath+paths.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 19.07.2024.
//

import UIKit

enum DrawingType {
	case raindropFirst
	case raindropSecond
	case road
	case cloud
	case snowflake
	case snowdrift
	case sunRay
	case star
	case crescentMoon
	case lightning
}

extension UIBezierPath {
	// MARK: - Public

	static func makePath(by drawingType: DrawingType, rect: CGRect) -> UIBezierPath {
		switch drawingType {
		case .raindropFirst:
			makeFirstRaindropPath(rect)
		case .raindropSecond:
			makeSecondRaindropPath(rect)
		case .road:
			makeRoadPath(rect)
		case .cloud:
			makeCloudPath(rect)
		case .snowflake:
			makeSnowflakePath(rect)
		case .snowdrift:
			makeSnowdriftPath(rect)
		case .sunRay:
			makeSunRayPath(rect)
		case .star:
			makeStarPath(rect)
		case .crescentMoon:
			makeCrescentMoonPath(rect)
		case .lightning:
			makeLightningPath(rect)
		}
	}

	// MARK: - Private

	static private func makeFirstRaindropPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()
		let sidePaddingMultiplier = 0.9

		path.move(to: CGPoint(x: rect.midX, y: rect.height * sidePaddingMultiplier))
		path.addCurve(
			to: CGPoint(x: rect.midX, y: rect.height * (1 - sidePaddingMultiplier)),
			controlPoint1: CGPoint(x: rect.width * 4 / 3, y: rect.height * sidePaddingMultiplier),
			controlPoint2: CGPoint(x: rect.width * pow(sidePaddingMultiplier, 2), y: rect.height / 3)
		)
		path.addCurve(
			to: CGPoint(x: rect.midX, y: rect.height * sidePaddingMultiplier),
			controlPoint1: CGPoint(x: rect.width * (1 - pow(sidePaddingMultiplier, 2)), y: rect.height / 3),
			controlPoint2: CGPoint(x: -rect.width / 3, y: rect.height * sidePaddingMultiplier)
		)
		path.close()
		path.fill()

		return path
	}

	static private func makeSecondRaindropPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()
		let raindropWidth: CGFloat = 4

		path.move(to: CGPoint(x: rect.midX - raindropWidth / 2, y: 0))
		path.addLine(to: CGPoint(x: rect.midX + raindropWidth / 2, y: 0))
		path.addLine(to: CGPoint(x: rect.midX + raindropWidth / 2, y: rect.height))
		path.addLine(to: CGPoint(x: rect.midX - raindropWidth / 2, y: rect.height))
		path.close()
		path.fill()

		return path
	}

	static func makeRoadPath(_ rect: CGRect) -> UIBezierPath {
		// Дорога

		let combinedPath = UIBezierPath()
		let roadPath = UIBezierPath()
		let roadStrokeWidth: CGFloat = 4

		roadPath.move(to: CGPoint(x: -roadStrokeWidth / 2, y: rect.height))
		roadPath.addLine(to: CGPoint(x: -roadStrokeWidth / 2, y: rect.height / 2))
		roadPath.addCurve(
			to: CGPoint(x: rect.width + roadStrokeWidth / 2, y: rect.height * 0.1),
			controlPoint1: CGPoint(x: rect.width / 6, y: rect.height / 3),
			controlPoint2: CGPoint(x: rect.width * 2 / 3, y: rect.height * 0.1)
		)
		roadPath.addLine(to: CGPoint(x: rect.width + roadStrokeWidth / 2, y: rect.height / 4))
		roadPath.addCurve(
			to: CGPoint(x: rect.width + roadStrokeWidth / 2, y: rect.height - rect.height / 2.5),
			controlPoint1: CGPoint(x: rect.width * 0.95, y: rect.height / 3),
			controlPoint2: CGPoint(x: rect.width * 0.95, y: rect.height / 2.6)
		)
		roadPath.addLine(to: CGPoint(x: rect.width + roadStrokeWidth / 2, y: rect.height + roadStrokeWidth / 2))
		roadPath.addLine(to: CGPoint(x: -roadStrokeWidth / 2, y: rect.height + roadStrokeWidth / 2))

		roadPath.close()
		roadPath.fill()
		AppColors.black.setFill()
		AppColors.white.setStroke()
		roadPath.lineWidth = roadStrokeWidth
		roadPath.stroke()

		// Левая разделительная линия

		let leftLinePath = UIBezierPath()

		leftLinePath.move(to: CGPoint(x: rect.width / 2 * 0.8, y: rect.height))
		leftLinePath.addCurve(
			to: CGPoint(x: rect.width, y: rect.height * 0.175 - 10),
			controlPoint1: CGPoint(x: rect.width / 2 * 0.85, y: rect.height / 3 * 2),
			controlPoint2: CGPoint(x: rect.width / 2 * 0.85, y: rect.height * 0.175)
		)
		leftLinePath.addCurve(
			to: CGPoint(x: rect.width / 2 * 0.9, y: rect.height),
			controlPoint1: CGPoint(x: rect.width / 2 * 0.88, y: rect.height * 0.2 - 8),
			controlPoint2: CGPoint(x: rect.width / 2 * 0.88, y: rect.height / 3 * 2)
		)

		leftLinePath.close()
		AppColors.white.setFill()
		leftLinePath.fill()

		// Левая разделительная линия

		let rightLinePath = UIBezierPath()

		rightLinePath.move(to: CGPoint(x: rect.width / 2 * 0.95, y: rect.height))
		rightLinePath.addCurve(
			to: CGPoint(x: rect.width, y: rect.height * 0.175 - 8),
			controlPoint1: CGPoint(x: rect.width / 2 * 0.95, y: rect.height / 3 * 2),
			controlPoint2: CGPoint(x: rect.width / 2 * 0.95, y: rect.height * 0.175)
		)
		rightLinePath.addCurve(
			to: CGPoint(x: rect.width / 2 * 1.05, y: rect.height),
			controlPoint1: CGPoint(x: rect.width / 2 * 1, y: rect.height * 0.2 - 8),
			controlPoint2: CGPoint(x: rect.width / 2 * 1, y: rect.height / 3 * 1.85)
		)

		rightLinePath.close()
		AppColors.white.setFill()
		rightLinePath.fill()

		combinedPath.append(roadPath)
		combinedPath.append(leftLinePath)
		combinedPath.append(rightLinePath)

		return combinedPath
	}

	static private func makeCloudPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()

		let verticalPadding: CGFloat = 2

		path.move(to: CGPoint(x: rect.width * 0.2, y: rect.height - verticalPadding))
		path.addLine(to: CGPoint(x: rect.width * 0.8, y: rect.height - verticalPadding))
		path.addCurve(
			to: CGPoint(x: rect.width * 0.8  - rect.width * 0.8 * 0.025, y: rect.height / 2),
			controlPoint1: CGPoint(x: rect.width * 0.98, y: rect.height - verticalPadding),
			controlPoint2: CGPoint(x: rect.width * 0.98, y: (rect.height - verticalPadding) / 2)
		)
		path.addCurve(
			to: CGPoint(x: rect.width / 2 + 20, y: rect.height / 3),
			controlPoint1: CGPoint(x: rect.width * 0.8  + rect.width * 0.8 * 0.05, y: rect.height / 5),
			controlPoint2: CGPoint(x: rect.width - rect.width / 2.4, y: rect.height - rect.height * 0.9)
		)
		path.addCurve(
			to: CGPoint(x: rect.width * 0.2, y: rect.height / 2),
			controlPoint1: CGPoint(x: rect.width / 2.4, y: rect.height - rect.height * 1.2),
			controlPoint2: CGPoint(x: rect.width / 10, y: rect.height - rect.height * 0.8)
		)
		path.addCurve(
			to: CGPoint(x: rect.width * 0.2, y: rect.height - verticalPadding),
			controlPoint1: CGPoint(x: rect.width / 98, y: (rect.height / verticalPadding) / 2),
			controlPoint2: CGPoint(x: rect.width / 98, y: rect.height - verticalPadding)
		)

		path.close()
		path.fill()

		return path
	}

	static private func makeSnowflakePath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()
		let center = CGPoint(x: rect.midX, y: rect.midY)

		// Function to draw a line from start to end with a given angle and length
		func drawLine(from start: CGPoint, angle: CGFloat, length: CGFloat) -> CGPoint {
			let end = CGPoint(x: start.x + length * cos(angle), y: start.y + length * sin(angle))
			path.move(to: start)
			path.addLine(to: end)
			return end
		}

		// Draw the main arms of the snowflake
		let mainArmLength: CGFloat = min(rect.width, rect.height) / 6 * 2.3
		for i in 0..<6 {
			let angle = CGFloat(i) * .pi / 3
			let mainArmEnd = drawLine(from: center, angle: angle, length: mainArmLength)

			// Draw branches on each main arm
			let branchLength: CGFloat = mainArmLength / 3
			let branchAngle: CGFloat = .pi / 3 // 15 degrees in radians

			for j in -2...2 {
				guard j != 0 else { continue }
				_ = drawLine(from: mainArmEnd, angle: angle + CGFloat(j) * branchAngle, length: branchLength)
			}
		}
		
		path.stroke()

		path.lineWidth = 2
		AppColors.white.setStroke()

		path.stroke()
		return path
	}

	static private func makeSnowdriftPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()

		path.move(to: CGPoint(x: 0, y: rect.height))
		path.addLine(to: CGPoint(x: 0, y: rect.height * 0.7))
		path.addCurve(
			to: CGPoint(x: rect.width / 2 * 1.3, y: rect.height * 0.7),
			controlPoint1: CGPoint(x: rect.width / 6, y: rect.height * 0.5),
			controlPoint2: CGPoint(x: rect.width / 2 * 1.3 * 0.8, y: rect.height * 0.85)
		)
		path.addLine(to: CGPoint(x: rect.width / 2 * 1.3, y: rect.height))
		path.close()

		let secondPath = UIBezierPath()

		secondPath.move(to: CGPoint(x: rect.width / 2 * 0.5, y: rect.height * 0.8))
		secondPath.addCurve(
			to: CGPoint(x: rect.width, y: rect.height * 0.6),
			controlPoint1: CGPoint(x: rect.width / 2 * 0.9, y: rect.height * 0.6),
			controlPoint2: CGPoint(x: rect.width * 0.9, y: rect.height * 0.6)
		)
		secondPath.addLine(to: CGPoint(x: rect.width, y: rect.height))
		secondPath.addLine(to: CGPoint(x: 0, y: rect.height))

		secondPath.close()

		let combinedPath = UIBezierPath()
		combinedPath.append(path)
		combinedPath.append(secondPath)

		combinedPath.lineWidth = 20
		AppColors.white.setStroke()
		combinedPath.fill()
		combinedPath.stroke()

		return combinedPath
	}

	static private func makeSunRayPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()

		path.move(to: CGPoint(x: rect.width / 2, y: rect.height))
		path.addLine(to: CGPoint(x: 0, y: 0))
		path.addLine(to: CGPoint(x: rect.width, y: 0))

		path.close()
		path.fill()

		return path
	}

	static private func makeStarPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()

		let topPoint = CGPoint(x: rect.midX, y: rect.minY)
		let rightPoint = CGPoint(x: rect.maxX, y: rect.midY)
		let bottomPoint = CGPoint(x: rect.midX, y: rect.maxY)
		let leftPoint = CGPoint(x: rect.minX, y: rect.midY)

		path.move(to: topPoint)
		path.addCurve(to: rightPoint,
					  controlPoint1: CGPoint(x: rect.midX + rect.width * 0.1, y: rect.minY + rect.height * 0.3),
					  controlPoint2: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.midY - rect.height * 0.1))
		path.addCurve(to: bottomPoint,
					  controlPoint1: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.midY + rect.height * 0.1),
					  controlPoint2: CGPoint(x: rect.midX + rect.width * 0.1, y: rect.maxY - rect.height * 0.3))
		path.addCurve(to: leftPoint,
					  controlPoint1: CGPoint(x: rect.midX - rect.width * 0.1, y: rect.maxY - rect.height * 0.3),
					  controlPoint2: CGPoint(x: rect.minX + rect.width * 0.3, y: rect.midY + rect.height * 0.1))
		path.addCurve(to: topPoint,
					  controlPoint1: CGPoint(x: rect.minX + rect.width * 0.3, y: rect.midY - rect.height * 0.1),
					  controlPoint2: CGPoint(x: rect.midX - rect.width * 0.1, y: rect.minY + rect.height * 0.3))

		path.close()
		path.fill()

		return path
	}

	static private func makeCrescentMoonPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()

		let startPoint = CGPoint(x: rect.width * 0.5, y: rect.height * 0.1)
		path.move(to: startPoint)

		let outerControlPoint1 = CGPoint(x: rect.width * 1.1, y: rect.height * 0.1)
		let outerControlPoint2 = CGPoint(x: rect.width * 1.1, y: rect.height * 0.9)
		let outerEndPoint = CGPoint(x: rect.width * 0.5, y: rect.height * 0.9)

		path.addCurve(to: outerEndPoint, controlPoint1: outerControlPoint1, controlPoint2: outerControlPoint2)
		let innerControlPoint1 = CGPoint(x: rect.width * 0.8, y: rect.height * 0.8)
		let innerControlPoint2 = CGPoint(x: rect.width * 0.8, y: rect.height * 0.2)
		let innerEndPoint = startPoint

		path.addCurve(to: innerEndPoint, controlPoint1: innerControlPoint1, controlPoint2: innerControlPoint2)

		path.close()
		path.fill()

		return path
	}

	static private func makeLightningPath(_ rect: CGRect) -> UIBezierPath {
//		let path = UIBezierPath()
//
//		path.move(to: CGPoint(x: rect.width / 2, y: 0))
//		path.addLine(to: CGPoint(x: 0, y: rect.height * 0.4))
//		path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.3))
//		path.addLine(to: CGPoint(x: rect.width * 0.1, y: rect.height))
//
//		return path
		let path = UIBezierPath()

		// Начальная точка сверху по центру
		var currentPoint = CGPoint(x: rect.width / 2, y: 0)
		path.move(to: currentPoint)

		while currentPoint.y < rect.height {
			// Генерация случайного смещения по X и фиксированного смещения по Y
			let randomXOffset = CGFloat(arc4random_uniform(UInt32(rect.width / 4))) - rect.width / 8
			let yOffset: CGFloat = .random(in: 7...20)

			// Новая точка
			let newPoint = CGPoint(x: currentPoint.x + randomXOffset, y: currentPoint.y + yOffset)
			path.addLine(to: newPoint)

			// Обновляем текущую точку
			currentPoint = newPoint
		}

		return path
	}
}
