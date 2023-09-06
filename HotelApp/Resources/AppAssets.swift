//
//  AppAssets.swift
//  HotelApp
//
//  Created by admin on 31.08.2023.
//

import Foundation
import UIKit

enum AppAssets: String {
    case starIcon
    case arrow
    case emojiHappy
    case tickSquare
    case closeSquare
    case arrowBtn
    case openBtn
    case closeBtn
    
    var image: UIImage? {
        rawValue.image
    }
}

extension String {
    var image: UIImage? {
        let image = UIImage(named: self)
        
        return image
    }
}
