//
//  PaymentCell.swift
//  HotelApp
//
//  Created by admin on 03.09.2023.
//

import UIKit

final class PaymentCell: BaseTableCell {
    @IBOutlet weak var tableView: UITableView!
    private var infoArray: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ofType: InfoCell.self)
    }
    
    func setup(model: BookingHotelDTO) {
        let allPrice = convertToPrice(number: model.price + model.fuelCharge + model.serviceCharge)
        let price = convertToPrice(number: model.price)
        let fuelCharge = convertToPrice(number: model.fuelCharge)
        let serviceCharge = convertToPrice(number: model.serviceCharge)
        
        infoArray = [price, fuelCharge, serviceCharge, allPrice]
    }
}

extension PaymentCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(ofType: InfoCell.self) else { return UITableViewCell() }
        let array = ["Тур", "Топливный сбор", "Сервисный сбор", "К оплате"]
        if (indexPath.row == 3) {
            cell.setup(name: array[indexPath.row], description: infoArray[indexPath.row], alignment: .right, color: .link, font: .semibold)
        } else {
            cell.setup(name: array[indexPath.row], description: infoArray[indexPath.row], alignment: .right)
        }
        
        return cell
    }
}
