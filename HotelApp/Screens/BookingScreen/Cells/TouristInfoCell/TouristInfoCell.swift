//
//  TouristInfoCell.swift
//  HotelApp
//
//  Created by admin on 03.09.2023.
//

import UIKit

final class TouristInfoCell: UITableViewCell {
    @IBOutlet private weak var touristLabel: UILabel!
    @IBOutlet private weak var expandBtn: UIButton!
    private var actionForBtn: () -> () = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(text: String, image: UIImage, action: @escaping () -> ()) {
        touristLabel.text = text
        expandBtn.setImage(image, for: .normal)
        actionForBtn = action
    }
    
    func updateImage(image: UIImage) {
        expandBtn.setImage(image, for: .normal)
    }
    
    @IBAction private func openCell() {
        actionForBtn()
    }
}
