//
//  BaseViewController.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 16.07.2024.
//

import UIKit

class BaseViewController: UIViewController {
	// MARK: - Lifecycle methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	private func setup() {
		view.backgroundColor = AppColors.white
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		hidesBottomBarWhenPushed = true
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		hidesBottomBarWhenPushed = true
	}
}
