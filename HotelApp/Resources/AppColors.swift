//
//  AppColors.swift
//  HotelApp
//
//  Created by admin on 31.08.2023.
//

import UIKit

enum AppColors: String {
    case yellowColor
    case yellowTextColor
    case grayColorText
    case grayBackground
    case errorColor
    
    var color: UIColor? {
        UIColor(named: self.rawValue)
    }
}
