//
//  ButtonCell.swift
//  HotelApp
//
//  Created by admin on 03.09.2023.
//

import UIKit

final class PayButtonCell: BaseTableCell {
    @IBOutlet private weak var payBtn: UIButton!
    private var actionForButton: () -> () = {}
    private var canPay: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(model: BookingHotelDTO, action: @escaping () -> ()) {
        actionForButton = action
        let allPrice = convertToPrice(number: model.price + model.fuelCharge + model.serviceCharge)
        payBtn.setTitle("Оплатить \(allPrice)", for: .normal)
    }
    
    @IBAction func goToNextScreen() {
        actionForButton()
    }
}
