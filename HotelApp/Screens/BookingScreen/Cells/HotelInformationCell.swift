//
//  HotelInfoCell.swift
//  HotelApp
//
//  Created by admin on 02.09.2023.
//

import UIKit

final class HotelInformationCell: BaseTableCell {
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var locationBtn: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingLabel.textColor = AppColors.yellowTextColor.color
        ratingLabel.backgroundColor = AppColors.yellowColor.color?.withAlphaComponent(0.2)
    }
    
    func setup(model: BookingHotelDTO) {
        nameLabel.text = model.hotelName
        nameLabel.sizeToFit()
        locationBtn.setTitle(model.hotelAddress, for: .normal)
        let ratingText = "\(model.horating) \(model.ratingName)"
        updateRatingLabel(text: ratingText, label: ratingLabel)
    }
}
