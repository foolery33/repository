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
	case sun
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
		case .sun:
			makeSunPath(rect)
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

		let topPoint = CGPoint(x: rect.midX, y: rect.height * sidePaddingMultiplier)
		let bottomPoint = CGPoint(x: rect.midX, y: rect.height * (1 - sidePaddingMultiplier))

		let bottomPointControlPoint1 = CGPoint(x: rect.width * 4 / 3, y: rect.height * sidePaddingMultiplier)
		let bottomPointControlPoint2 = CGPoint(x: rect.width * pow(sidePaddingMultiplier, 2), y: rect.height / 3)

		let topPointControlPoint1 = CGPoint(x: rect.width * (1 - pow(sidePaddingMultiplier, 2)), y: rect.height / 3)
		let topPointControlPoint2 = CGPoint(x: -rect.width / 3, y: rect.height * sidePaddingMultiplier)

		path.move(to: topPoint)
		path.addCurve(to: bottomPoint, controlPoint1: bottomPointControlPoint1, controlPoint2: bottomPointControlPoint2)
		path.addCurve(to: topPoint, controlPoint1: topPointControlPoint1, controlPoint2: topPointControlPoint2)
		path.close()
		path.fill()

		return path
	}

	static private func makeSecondRaindropPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()
		let raindropWidth: CGFloat = 4
		let leftX = rect.midX - raindropWidth / 2
		let rightX = rect.midX + raindropWidth / 2
		let topY: CGFloat = 0
		let bottomY = rect.height

		path.move(to: CGPoint(x: leftX, y: topY))
		path.addLine(to: CGPoint(x: rightX, y: topY))
		path.addLine(to: CGPoint(x: rightX, y: bottomY))
		path.addLine(to: CGPoint(x: leftX, y: bottomY))
		path.close()
		path.fill()

		return path
	}

	static func makeRoadPath(_ rect: CGRect) -> UIBezierPath {
		let combinedPath = UIBezierPath()
		let roadPath = UIBezierPath()
		let roadStrokeWidth: CGFloat = 4

		// Road
		let roadStartPoint = CGPoint(x: -roadStrokeWidth / 2, y: rect.height)
		let roadMidPoint = CGPoint(x: -roadStrokeWidth / 2, y: rect.height / 2)
		let roadCurveEndPoint = CGPoint(x: rect.width + roadStrokeWidth / 2, y: rect.height * 0.1)
		let roadCurveControlPoint1 = CGPoint(x: rect.width / 6, y: rect.height / 3)
		let roadCurveControlPoint2 = CGPoint(x: rect.width * 2 / 3, y: rect.height * 0.1)
		let roadLineEndPoint = CGPoint(x: rect.width + roadStrokeWidth / 2, y: rect.height / 4)
		let roadCurveEndPoint2 = CGPoint(x: rect.width + roadStrokeWidth / 2, y: rect.height - rect.height / 2.5)
		let roadCurveControlPoint3 = CGPoint(x: rect.width * 0.95, y: rect.height / 3)
		let roadCurveControlPoint4 = CGPoint(x: rect.width * 0.95, y: rect.height / 2.6)
		let roadBottomRightCorner = CGPoint(x: rect.width + roadStrokeWidth / 2, y: rect.height + roadStrokeWidth / 2)
		let roadBottomLeftCorner = CGPoint(x: -roadStrokeWidth / 2, y: rect.height + roadStrokeWidth / 2)

		roadPath.move(to: roadStartPoint)
		roadPath.addLine(to: roadMidPoint)
		roadPath.addCurve(to: roadCurveEndPoint, controlPoint1: roadCurveControlPoint1, controlPoint2: roadCurveControlPoint2)
		roadPath.addLine(to: roadLineEndPoint)
		roadPath.addCurve(to: roadCurveEndPoint2, controlPoint1: roadCurveControlPoint3, controlPoint2: roadCurveControlPoint4)
		roadPath.addLine(to: roadBottomRightCorner)
		roadPath.addLine(to: roadBottomLeftCorner)

		roadPath.close()
		roadPath.fill()
		AppColors.black.setFill()
		AppColors.white.setStroke()
		roadPath.lineWidth = roadStrokeWidth
		roadPath.stroke()

		// Left Divider Line
		let leftLinePath = UIBezierPath()
		let leftLineStartPoint = CGPoint(x: rect.width / 2 * 0.8, y: rect.height)
		let leftLineCurveEndPoint = CGPoint(x: rect.width, y: rect.height * 0.175 - 10)
		let leftLineCurveControlPoint1 = CGPoint(x: rect.width / 2 * 0.85, y: rect.height / 3 * 2)
		let leftLineCurveControlPoint2 = CGPoint(x: rect.width / 2 * 0.85, y: rect.height * 0.175)
		let leftLineCurveEndPoint2 = CGPoint(x: rect.width / 2 * 0.9, y: rect.height)
		let leftLineCurveControlPoint3 = CGPoint(x: rect.width / 2 * 0.88, y: rect.height * 0.2 - 8)
		let leftLineCurveControlPoint4 = CGPoint(x: rect.width / 2 * 0.88, y: rect.height / 3 * 2)

		leftLinePath.move(to: leftLineStartPoint)
		leftLinePath.addCurve(to: leftLineCurveEndPoint, controlPoint1: leftLineCurveControlPoint1, controlPoint2: leftLineCurveControlPoint2)
		leftLinePath.addCurve(to: leftLineCurveEndPoint2, controlPoint1: leftLineCurveControlPoint3, controlPoint2: leftLineCurveControlPoint4)

		leftLinePath.close()
		AppColors.white.setFill()
		leftLinePath.fill()

		// Right Divider Line
		let rightLinePath = UIBezierPath()
		let rightLineStartPoint = CGPoint(x: rect.width / 2 * 0.95, y: rect.height)
		let rightLineCurveEndPoint = CGPoint(x: rect.width, y: rect.height * 0.175 - 8)
		let rightLineCurveControlPoint1 = CGPoint(x: rect.width / 2 * 0.95, y: rect.height / 3 * 2)
		let rightLineCurveControlPoint2 = CGPoint(x: rect.width / 2 * 0.95, y: rect.height * 0.175)
		let rightLineCurveEndPoint2 = CGPoint(x: rect.width / 2 * 1.05, y: rect.height)
		let rightLineCurveControlPoint3 = CGPoint(x: rect.width / 2 * 1, y: rect.height * 0.2 - 8)
		let rightLineCurveControlPoint4 = CGPoint(x: rect.width / 2 * 1, y: rect.height / 3 * 1.85)

		rightLinePath.move(to: rightLineStartPoint)
		rightLinePath.addCurve(to: rightLineCurveEndPoint, controlPoint1: rightLineCurveControlPoint1, controlPoint2: rightLineCurveControlPoint2)
		rightLinePath.addCurve(to: rightLineCurveEndPoint2, controlPoint1: rightLineCurveControlPoint3, controlPoint2: rightLineCurveControlPoint4)

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
		let startPoint = CGPoint(x: rect.width * 0.2, y: rect.height - verticalPadding)
		let endPoint = CGPoint(x: rect.width * 0.8, y: rect.height - verticalPadding)
		let firstCurveEndPoint = CGPoint(x: rect.width * 0.8 - rect.width * 0.8 * 0.025, y: rect.height / 2)
		let firstCurveControlPoint1 = CGPoint(x: rect.width * 0.98, y: rect.height - verticalPadding)
		let firstCurveControlPoint2 = CGPoint(x: rect.width * 0.98, y: (rect.height - verticalPadding) / 2)
		let secondCurveEndPoint = CGPoint(x: rect.width / 2 + 20, y: rect.height / 3)
		let secondCurveControlPoint1 = CGPoint(x: rect.width * 0.8 + rect.width * 0.8 * 0.05, y: rect.height / 5)
		let secondCurveControlPoint2 = CGPoint(x: rect.width - rect.width / 2.4, y: rect.height - rect.height * 0.9)
		let thirdCurveEndPoint = CGPoint(x: rect.width * 0.2, y: rect.height / 2)
		let thirdCurveControlPoint1 = CGPoint(x: rect.width / 2.4, y: rect.height - rect.height * 1.2)
		let thirdCurveControlPoint2 = CGPoint(x: rect.width / 10, y: rect.height - rect.height * 0.8)
		let fourthCurveControlPoint1 = CGPoint(x: rect.width / 98, y: (rect.height / verticalPadding) / 2)
		let fourthCurveControlPoint2 = CGPoint(x: rect.width / 98, y: rect.height - verticalPadding)

		path.move(to: startPoint)
		path.addLine(to: endPoint)
		path.addCurve(to: firstCurveEndPoint, controlPoint1: firstCurveControlPoint1, controlPoint2: firstCurveControlPoint2)
		path.addCurve(to: secondCurveEndPoint, controlPoint1: secondCurveControlPoint1, controlPoint2: secondCurveControlPoint2)
		path.addCurve(to: thirdCurveEndPoint, controlPoint1: thirdCurveControlPoint1, controlPoint2: thirdCurveControlPoint2)
		path.addCurve(to: startPoint, controlPoint1: fourthCurveControlPoint1, controlPoint2: fourthCurveControlPoint2)

		path.close()
		path.fill()

		return path
	}

	static private func makeSnowflakePath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()
		let center = CGPoint(x: rect.midX, y: rect.midY)

		let mainArmLength: CGFloat = min(rect.width, rect.height) / 6 * 2.3
		let branchLength: CGFloat = mainArmLength / 3
		let branchAngle: CGFloat = .pi / 3

		for i in 0..<6 {
			let angle = CGFloat(i) * .pi / 3
			let mainArmEndX = center.x + mainArmLength * cos(angle)
			let mainArmEndY = center.y + mainArmLength * sin(angle)
			let mainArmEnd = CGPoint(x: mainArmEndX, y: mainArmEndY)

			path.move(to: center)
			path.addLine(to: mainArmEnd)

			for j in -2...2 {
				guard j != 0 else { continue }
				let branchAngleOffset = CGFloat(j) * branchAngle
				let branchEndX = mainArmEndX + branchLength * cos(angle + branchAngleOffset)
				let branchEndY = mainArmEndY + branchLength * sin(angle + branchAngleOffset)
				let branchEnd = CGPoint(x: branchEndX, y: branchEndY)

				path.move(to: mainArmEnd)
				path.addLine(to: branchEnd)
			}
		}

		path.lineWidth = 2
		AppColors.white.setStroke()
		path.stroke()

		return path
	}

	static private func makeSnowdriftPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()

		let topRightControlPoint = CGPoint(x: rect.width / 2 * 1.3, y: rect.height * 0.7)
		let topControlPoint1 = CGPoint(x: rect.width / 6, y: rect.height * 0.5)
		let topControlPoint2 = CGPoint(x: rect.width / 2 * 1.3 * 0.8, y: rect.height * 0.85)

		path.move(to: CGPoint(x: 0, y: rect.height))
		path.addLine(to: CGPoint(x: 0, y: rect.height * 0.7))
		path.addCurve(to: topRightControlPoint, controlPoint1: topControlPoint1, controlPoint2: topControlPoint2)
		path.addLine(to: CGPoint(x: rect.width / 2 * 1.3, y: rect.height))
		path.close()

		let secondPath = UIBezierPath()

		let secondPathStartPoint = CGPoint(x: rect.width / 2 * 0.5, y: rect.height * 0.8)
		let secondPathEndPoint = CGPoint(x: rect.width, y: rect.height * 0.6)
		let secondPathControlPoint1 = CGPoint(x: rect.width / 2 * 0.9, y: rect.height * 0.6)
		let secondPathControlPoint2 = CGPoint(x: rect.width * 0.9, y: rect.height * 0.6)

		secondPath.move(to: secondPathStartPoint)
		secondPath.addCurve(to: secondPathEndPoint, controlPoint1: secondPathControlPoint1, controlPoint2: secondPathControlPoint2)
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

	static private func makeSunPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()

		let center = CGPoint(x: rect.midX, y: rect.midY)
		let radius = min(rect.width, rect.height) / 2

		path.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)

		path.close()
		path.fill()

		return path
	}

	static private func makeSunRayPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()

		let startPoint = CGPoint(x: rect.width / 2, y: rect.height)
		let topLeftPoint = CGPoint(x: 0, y: 0)
		let topRightPoint = CGPoint(x: rect.width, y: 0)

		path.move(to: startPoint)
		path.addLine(to: topLeftPoint)
		path.addLine(to: topRightPoint)
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

		let topControl1 = CGPoint(x: rect.midX + rect.width * 0.1, y: rect.minY + rect.height * 0.3)
		let topControl2 = CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.midY - rect.height * 0.1)

		let rightControl1 = CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.midY + rect.height * 0.1)
		let rightControl2 = CGPoint(x: rect.midX + rect.width * 0.1, y: rect.maxY - rect.height * 0.3)

		let bottomControl1 = CGPoint(x: rect.midX - rect.width * 0.1, y: rect.maxY - rect.height * 0.3)
		let bottomControl2 = CGPoint(x: rect.minX + rect.width * 0.3, y: rect.midY + rect.height * 0.1)

		let leftControl1 = CGPoint(x: rect.minX + rect.width * 0.3, y: rect.midY - rect.height * 0.1)
		let leftControl2 = CGPoint(x: rect.midX - rect.width * 0.1, y: rect.minY + rect.height * 0.3)

		path.move(to: topPoint)
		path.addCurve(to: rightPoint, controlPoint1: topControl1, controlPoint2: topControl2)
		path.addCurve(to: bottomPoint, controlPoint1: rightControl1, controlPoint2: rightControl2)
		path.addCurve(to: leftPoint, controlPoint1: bottomControl1, controlPoint2: bottomControl2)
		path.addCurve(to: topPoint, controlPoint1: leftControl1, controlPoint2: leftControl2)

		path.close()
		path.fill()

		return path
	}

	static private func makeCrescentMoonPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()

		let startPoint = CGPoint(x: rect.width * 0.5, y: rect.height * 0.1)

		let outerControlPoint1 = CGPoint(x: rect.width * 1.1, y: rect.height * 0.1)
		let outerControlPoint2 = CGPoint(x: rect.width * 1.1, y: rect.height * 0.9)
		let outerEndPoint = CGPoint(x: rect.width * 0.5, y: rect.height * 0.9)

		let innerControlPoint1 = CGPoint(x: rect.width * 0.8, y: rect.height * 0.8)
		let innerControlPoint2 = CGPoint(x: rect.width * 0.8, y: rect.height * 0.2)
		let innerEndPoint = startPoint

		path.move(to: startPoint)
		path.addCurve(to: outerEndPoint, controlPoint1: outerControlPoint1, controlPoint2: outerControlPoint2)
		path.addCurve(to: innerEndPoint, controlPoint1: innerControlPoint1, controlPoint2: innerControlPoint2)

		path.close()
		path.fill()

		return path
	}


	static private func makeLightningPath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()

		let initialPoint = CGPoint(x: rect.width / 2, y: 0)
		let minYOffset: CGFloat = 7
		let maxYOffset: CGFloat = 20
		let maxXOffset: CGFloat = rect.width / 4

		path.move(to: initialPoint)

		var currentPoint = initialPoint

		while currentPoint.y < rect.height {
			let randomXOffset = CGFloat(arc4random_uniform(UInt32(maxXOffset))) - (maxXOffset / 2)
			let yOffset = CGFloat.random(in: minYOffset...maxYOffset)

			let newPoint = CGPoint(x: currentPoint.x + randomXOffset, y: currentPoint.y + yOffset)
			path.addLine(to: newPoint)

			currentPoint = newPoint
		}

		return path
	}

}
