//
//  BookingCell.swift
//  HotelApp
//
//  Created by admin on 02.09.2023.
//

import UIKit

final class BookingCell: UITableViewCell {
    @IBOutlet private weak var tableView: UITableView!
    private var infoArray: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ofType: InfoCell.self)
    }
    
    func setup(model: BookingHotelDTO) {
        infoArray = [model.departure, model.arrivalCountry, "\(model.tourStart) - \(model.tourStop)", "\(model.numberOfNights) ночей", model.hotelName, model.room, model.nutrition]
    }
}

extension BookingCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(ofType: InfoCell.self) else { return UITableViewCell() }
        let array = ["Вылет из", "Страна, город", "Даты", "Кол-во ночей", "Отель", "Номер", "Питание"]
        cell.setup(name: array[indexPath.row], description: infoArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
}
