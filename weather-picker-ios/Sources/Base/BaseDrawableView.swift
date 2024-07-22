//
//  BaseDrawableView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 19.07.2024.
//

import UIKit

final class BaseDrawableView: UIView {
	// MARK: - Init

	init(drawingType: DrawingType, frame: CGRect? = nil) {
		self.drawingType = drawingType
		super.init(frame: frame ?? .zero)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Override

	override func draw(_ rect: CGRect) {
		let bezierPath = UIBezierPath.makePath(by: drawingType, rect: rect)
		layer.shadowPath = bezierPath.cgPath
		self.bezierPath = bezierPath
		onPathReceived?(bezierPath.cgPath)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		gradient?.frame = bounds
	}

	// MARK: - Public

	var onPathReceived: ((CGPath) -> Void)?
	var shapeLayer: CAShapeLayer?

	func addGradient(_ gradient: CAGradientLayer) {
		self.gradient = gradient
		layer.addSublayer(gradient)
	}

	func setAnimations(
		startAnimations: [(anim: CAAnimation, key: String)] = [],
		stopAnimations: [(anim: CAAnimation, key: String)] = []
	) {
		self.startAnimations = startAnimations
		self.stopAnimations = stopAnimations
	}

	func setDelayedAnimation(_ animation: (anim: CAAnimation, key: String), delay: Double) {
		DispatchQueue.main.asyncAfter(deadline: .now() + .random(in: delay...delay)) {
			self.layer.add(animation.anim, forKey: animation.key)
		}
	}

	// MARK: - Private

	private let drawingType: DrawingType
	private var gradient: CAGradientLayer?
	private var gradientMask: CAShapeLayer?

	private var startAnimations: [(anim: CAAnimation, key: String)] = []
	private var stopAnimations: [(anim: CAAnimation, key: String)] = []

	private var bezierPath: UIBezierPath? {
		didSet {
			makeGradientMask()
		}
	}

	private func setup() {
		backgroundColor = .clear
	}

	private func makeGradientMask() {
		self.gradientMask = CAShapeLayer()
		gradientMask?.path = bezierPath?.cgPath
		self.gradient?.mask = gradientMask
		self.gradient?.frame = bounds
		layer.shadowPath = bezierPath?.cgPath
	}
}

// MARK: - ViewAnimatable

extension BaseDrawableView: ViewAnimatable {
	func startAnimation() {
		for animation in startAnimations {
			layer.add(animation.anim, forKey: animation.key)
		}
	}

	func stopAnimation(completion: @escaping (() -> Void)) {
		for animation in stopAnimations {
			layer.add(animation.anim, forKey: animation.key)
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
}
