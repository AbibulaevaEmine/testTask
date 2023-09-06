//
//  AddNewTouristCell.swift
//  HotelApp
//
//  Created by admin on 04.09.2023.
//

import UIKit

final class AddNewTouristCell: UITableViewCell {
    private var onAddNewTouristTapped: () -> () = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(action: @escaping () -> ()) {
        onAddNewTouristTapped = action
    }
    
    @IBAction func addTourist() {
        onAddNewTouristTapped()
    }
}
