//
//  InfoCell.swift
//  HotelApp
//
//  Created by admin on 02.09.2023.
//

import UIKit

final class InfoCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(name: String, description: String, alignment: NSTextAlignment = .left, color: UIColor = .black, font: UIFont.Weight = .regular) {
        nameLabel.text = name
        descriptionLabel.text = description
        descriptionLabel.textAlignment = alignment
        descriptionLabel.textColor = color
        descriptionLabel.font = .systemFont(ofSize: 16, weight: font)
        nameLabel.sizeToFit()
        descriptionLabel.sizeToFit()
    }
}
