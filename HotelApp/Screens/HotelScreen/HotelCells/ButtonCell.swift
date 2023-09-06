//
//  ButtonCell.swift
//  HotelApp
//
//  Created by admin on 31.08.2023.
//

import UIKit

final class ButtonCell: UITableViewCell {
    private var buttonAction: () -> () = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
    }

    @IBAction func openHotelsList() {
        buttonAction()
    }
    
    func setup(actionForButton: @escaping () -> ()) {
        buttonAction = actionForButton
    }
}
