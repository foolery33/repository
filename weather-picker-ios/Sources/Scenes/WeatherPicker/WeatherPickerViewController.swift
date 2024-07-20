//
//  WeatherPickerViewController.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit
import SnapKit

final class WeatherPickerViewController: UIViewController {
	// MARK: - Init

	init(viewModel: WeatherPickerViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		backgroundGradient.frame = backgroundGradientView.bounds
		scrollToSelectedWeatherType()
	}

	// MARK: - Private

	private let viewModel: WeatherPickerViewModel
	private var firstDidLayoutSubviewsCall: Bool = true

	private let weatherPickerScrollView = UIScrollView()
	private let weatherPickerStackView = UIStackView()
	private var backgroundGradientView = UIView()
	private lazy var backgroundGradient = viewModel.weatherType.backgroundGradient
	private lazy var weatherView: ViewAnimatable? = viewModel.weatherType.view

	private func setup() {
		setupBindings()
		setupBackgroundGradientView()
		setupWeatherPickerScrollView()
		setupWeatherPickerStackView()
		setupWeatherView()
	}

	private func setupBindings() {
		viewModel.onWeatherTypeUpdated = { [weak self] newWeatherView in
			guard let self else { return }
			self.updateView(to: newWeatherView)
		}
	}

	private func setupBackgroundGradientView() {
		view.addSubview(backgroundGradientView)
		backgroundGradientView.frame = view.bounds
		backgroundGradientView.layer.addSublayer(backgroundGradient)
	}

	private func setupWeatherView() {
		guard let weatherView else { return }

		view.addSubview(weatherView)
		view.bringSubviewToFront(weatherPickerScrollView)

		weatherView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}

	private func setupWeatherPickerScrollView() {
		weatherPickerScrollView.showsHorizontalScrollIndicator = false
		weatherPickerScrollView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

		view.addSubview(weatherPickerScrollView)

		weatherPickerScrollView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
			make.width.equalToSuperview()
		}
	}

	private func setupWeatherPickerStackView() {
		weatherPickerStackView.spacing = 8

		for weatherType in WeatherType.allCases {
			let view = WeatherPickerElementView(weatherType: weatherType)
			view.isSelected = weatherType == viewModel.weatherType
			view.onDidTap = { [weak self] weatherType in
				guard let self, let weatherView else { return }
				self.weatherPickerStackView.arrangedSubviews.forEach { view in
					(view as? WeatherPickerElementView)?.isSelected = (view as? WeatherPickerElementView)?.weatherType == weatherType
				}
				weatherView.stopAnimation() {
					self.viewModel.weatherType = weatherType
				}
			}

			weatherPickerStackView.addArrangedSubview(view)
		}

		weatherPickerScrollView.addSubview(weatherPickerStackView)

		weatherPickerStackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
			make.height.equalToSuperview()
		}
	}

	private func updateView(to weatherView: ViewAnimatable) {
		self.weatherView?.removeFromSuperview()
		self.weatherView = weatherView
		setupWeatherView()
		updateBackgroundGradientView()
	}

	private func updateBackgroundGradientView() {
		let newGradientLayer = viewModel.weatherType.backgroundGradient

		let newGradientView = UIView(frame: backgroundGradientView.bounds)
		newGradientView.layer.addSublayer(newGradientLayer)
		newGradientLayer.frame = newGradientView.bounds

		view.addSubview(newGradientView)
		view.sendSubviewToBack(newGradientView)
		UIView.transition(from: backgroundGradientView, to: newGradientView, duration: 0.5, options: [.transitionCrossDissolve, .showHideTransitionViews]) { _ in
			self.backgroundGradientView.removeFromSuperview()
			self.backgroundGradientView = newGradientView
		}
	}

	private func scrollToSelectedWeatherType() {
		guard firstDidLayoutSubviewsCall else { return }
		guard let selectedSubviews = weatherPickerStackView.arrangedSubviews as? [WeatherPickerElementView] else { return }
		guard let selectedSubview = selectedSubviews.first(where: { $0.isSelected }), selectedSubview.bounds != .zero else { return }

		weatherPickerScrollView.scrollRectToVisible(selectedSubview.frame, animated: true)
		
		firstDidLayoutSubviewsCall = false
	}
}
