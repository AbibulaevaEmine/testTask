//
//  FinishBookingVC.swift
//  HotelApp
//
//  Created by admin on 02.09.2023.
//

import UIKit

final class FinishBookingVC: UIViewController {
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "Заказ оплачен"
    }
    
    private func setupUI() {
        let randomNumber = Int.random(in: 100000..<1000000)
        descriptionLabel.text = "Подтверждение заказа №\(randomNumber) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
        descriptionLabel.sizeToFit()
        backgroundView.layer.cornerRadius = 47
        backgroundView.backgroundColor = AppColors.grayBackground.color
    }
    // MARK: - Navigation
    @IBAction func buttonAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
