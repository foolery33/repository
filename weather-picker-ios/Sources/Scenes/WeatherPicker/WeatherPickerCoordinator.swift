//
//  WeatherPickerCoordinator.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit

final class WeatherPickerCoordinator: Coordinator {
	// MARK: - Init

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Public

	let navigationController: UINavigationController

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	// MARK: - Navigation

	func start(animated: Bool) {
		let viewModel = WeatherPickerViewModel(weatherType: WeatherType.allCases.randomElement() ?? .clear)
		let viewController = WeatherPickerViewController(viewModel: viewModel)
		
		navigationController.setNavigationBarHidden(true, animated: false)
		navigationController.pushViewController(viewController, animated: animated)
	}
}
