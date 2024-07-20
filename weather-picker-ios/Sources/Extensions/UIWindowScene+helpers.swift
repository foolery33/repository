//
//  UIWindowScene+helpers.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

extension UIWindowScene {
	var sceneKeyWindow: UIWindow? {
		windows.first { $0.isKeyWindow && $0.isUserInteractionEnabled }
	}
}
