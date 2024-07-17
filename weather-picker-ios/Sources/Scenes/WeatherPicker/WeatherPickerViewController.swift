//
//  WeatherPickerViewController.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit
import SnapKit

final class WeatherPickerViewController: BaseViewController, NavigationBarHiding {
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

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		backgroundGradient.frame = view.bounds
	}

	// MARK: - Private

	private let viewModel: WeatherPickerViewModel

	private let backgroundGradient = WeatherType.clear.backgroundGradient

	private let weatherPickerScrollView = UIScrollView()
	private let weatherPickerStackView = UIStackView()
	private let backgroundGradientView = UIView()
	private lazy var weatherView: ViewAnimatable? = viewModel.getWeatherView() {
		didSet {
			setupWeatherView()
		}
	}

	private func setup() {
		setupBindings()
		configureView()
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

	private func configureView() {
		view.layer.addSublayer(backgroundGradient)
	}

	private func setupWeatherView() {
		guard let weatherView else { return }

		view.addSubview(weatherView)

		weatherView.snp.makeConstraints { make in
			make.center.equalToSuperview()
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
	}
}
