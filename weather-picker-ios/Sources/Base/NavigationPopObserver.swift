//
//  NavigationPopObserver.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit

final class NavigationPopObserver {
	let observedViewController: UIViewController

	private let coordinator: Coordinator

	init(observedViewController: UIViewController, coordinator: Coordinator) {
		self.observedViewController = observedViewController
		self.coordinator = coordinator
	}

	func didObservePop() {
		coordinator.onDidFinish?()
	}
}
