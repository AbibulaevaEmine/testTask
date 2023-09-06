//
//  UsabilityCell.swift
//  HotelApp
//
//  Created by admin on 31.08.2023.
//

import UIKit

final class UsabilityCell: UITableViewCell {
    @IBOutlet private weak var nameCategory: UILabel!
    @IBOutlet private weak var cellIcon: UIImageView!
    
    func setup(icon: UIImage, category: String) {
        nameCategory.text = category
        cellIcon.image = icon
    }
}
