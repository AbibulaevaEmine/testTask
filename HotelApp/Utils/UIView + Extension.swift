//
//  UIView + Extension.swift
//  HotelApp
//
//  Created by admin on 05.09.2023.
//

import Foundation
import UIKit

extension UIView {
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
