//
//  WeatherPickerElementView.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit

final class WeatherPickerElementView: UIView {
	// MARK: - Init

	init(weatherType: WeatherType?) {
		self.weatherType = weatherType
		super.init(frame: .zero)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Override

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		elementImageView.alpha = 0.6
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		elementImageView.alpha = 1
	}

	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesCancelled(touches, with: event)
		elementImageView.alpha = 1
	}

	// MARK: - Public

	var onDidTap: ((WeatherType) -> Void)?

	var isSelected: Bool = false {
		didSet {
			UIView.animate(withDuration: 0.3) {
				if self.isSelected {
					self.backgroundColor = AppColors.blueGray
					self.elementTextLabel.textColor = AppColors.white
				} else {
					self.backgroundColor = AppColors.white
					self.elementTextLabel.textColor = AppColors.blueGray
				}
			}
		}
	}

	let weatherType: WeatherType?

	// MARK: - Actions

	@objc
	private func handleTap() {
		guard let weatherType else { return }
		onDidTap?(weatherType)
	}

	// MARK: - Private

	private let elementImageView = UIImageView()
	private let elementTextLabel = UILabel()

	private func setup() {
		configureView()
		setupElementImageView()
		setupElementText()
	}

	private func configureView() {
		backgroundColor = AppColors.white
		layer.cornerRadius = 12
		layer.borderWidth = 1
		layer.borderColor = AppColors.darkPurple.cgColor
		addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
	}

	private func setupElementImageView() {
		elementImageView.image = weatherType?.icon

		addSubview(elementImageView)

		elementImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			elementImageView.widthAnchor.constraint(equalToConstant: 22),
			elementImageView.heightAnchor.constraint(equalToConstant: 22),
			elementImageView.topAnchor.constraint(equalTo: elementImageView.superview!.topAnchor, constant: 4),
			elementImageView.bottomAnchor.constraint(equalTo: elementImageView.superview!.bottomAnchor, constant: -4),
			elementImageView.leadingAnchor.constraint(equalTo: elementImageView.superview!.leadingAnchor, constant: 8)
		])
	}

	private func setupElementText() {
		elementTextLabel.text = weatherType?.text
		elementTextLabel.textColor = AppColors.blueGray
		elementTextLabel.font = .systemFont(ofSize: 16, weight: .semibold)

		addSubview(elementTextLabel)

		elementTextLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			elementTextLabel.centerYAnchor.constraint(equalTo: elementImageView.centerYAnchor),
			elementTextLabel.leadingAnchor.constraint(equalTo: elementImageView.trailingAnchor, constant: 4),
			elementTextLabel.trailingAnchor.constraint(equalTo: elementTextLabel.superview!.trailingAnchor, constant: -8)
		])
	}
}
