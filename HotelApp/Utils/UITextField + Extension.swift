//
//  UITextField + Extension.swift
//  HotelApp
//
//  Created by admin on 05.09.2023.
//

import Foundation
import UIKit

extension UITextField {
    func setPadding(left: CGFloat, right: CGFloat) {
        let paddingLeftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: frame.height))
        leftView = paddingLeftView
        leftViewMode = .always
        
        let paddingRightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: frame.height))
        rightView = paddingRightView
        rightViewMode = .always
    }
}
