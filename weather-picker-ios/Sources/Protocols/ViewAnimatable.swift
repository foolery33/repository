//
//  ViewAnimatable.swift
//  weather-picker-ios
//
//  Created by Nikita Usov on 17.07.2024.
//

import UIKit

protocol ViewAnimatable: UIView {
	func startAnimation()
	func stopAnimation(completion: @escaping (() -> Void))
}
