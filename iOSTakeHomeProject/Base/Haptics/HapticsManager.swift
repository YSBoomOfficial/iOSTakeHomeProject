//
//  HapticsManager.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation
import UIKit

final class HapticsManager {
	static let shared = HapticsManager()

	private let feedback = UINotificationFeedbackGenerator()

	private init() {}

	func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
		feedback.notificationOccurred(notification)
	}
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
	if UserDefaults.standard.bool(forKey: UserDefaultsKeys.hapticsEnabled) {
		HapticsManager.shared.trigger(notification)
	}
}
