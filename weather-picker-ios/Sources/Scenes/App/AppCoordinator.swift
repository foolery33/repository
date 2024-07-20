//
//  AppCoordinator.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
	// MARK: - Init

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Public

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	let navigationController: UINavigationController

	func start(animated: Bool) {
		showWeatherPickerScreen(animated: animated)
	}

	// MARK: - Private

	private func showWeatherPickerScreen(animated: Bool) {
		show(WeatherPickerCoordinator.self, animated: animated)
	}
}
