//
//  CGPath+paths.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 19.07.2024.
//

import UIKit

extension UIBezierPath {
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
}
