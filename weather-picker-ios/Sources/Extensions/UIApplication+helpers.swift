//
//  UIApplication+helpers.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

extension UIApplication {
	var scene: UIWindowScene? {
		connectedScenes.first { $0 is UIWindowScene } as? UIWindowScene
	}

	var windowSize: CGSize {
		scene?.sceneKeyWindow?.bounds.size ?? UIScreen.main.bounds.size
	}
}
