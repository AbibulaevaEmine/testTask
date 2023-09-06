//
//  BookingVM.swift
//  HotelApp
//
//  Created by admin on 02.09.2023.
//

import Foundation
import RxSwift

protocol PBookingVM {
    func getBookingData()
    var model: BookingHotelDTO? { get }
    func ordinalString(_ n: Int) -> String
    func validateTouristInfo(touristsCount: Int, tableView: UITableView) -> Bool
}

final class BookingVM: PBookingVM {
    weak var view: PBookingVC?
    var apiServices: ApiServices?
    private let disposeBag = DisposeBag()
    var model: BookingHotelDTO?
    
    func ordinalString(_ n: Int) -> String {
        let endings = ["-ый","-ой","-ий"]
        
        let numberString = String(n)
        let lastDigit = Int(String(numberString.last!))!
        var result = ""
        
        if n % 100 > 10 && n % 100 < 20 {
            result = numberString + "-ый"
        } else if lastDigit == 1 {
            result = numberString + endings[0]
        } else if lastDigit == 2 || lastDigit == 7 {
            result = numberString + endings[1]
        } else if lastDigit > 0 && lastDigit < 10 {
            result = numberString + endings[2]
        } else {
            result = numberString + "-ый"
        }
        
        // Склонение числительных
        let numerals = [
            "Первый", "Второй", "Третий", "Четвертый", "Пятый", "Шестой",
            "Седьмой", "Восьмой", "Девятый", "Десятый"]
        
        if n <= 10 {
            return "\(numerals[n]) турист"
        }
        
        return result + " турист"
    }
    
    func validateTouristInfo(touristsCount: Int, tableView: UITableView) -> Bool {
        var isValid = true
        for index in 0..<touristsCount {
            if let cellIndexPath = IndexPath(row: 2 * index + 4, section: 0) as IndexPath?,
               let touristFullInfoCell = tableView.cellForRow(at: cellIndexPath) as? TouristFullInfoCell {
                if !touristFullInfoCell.validate() {
                    isValid = false
                }
            }
        }
        return isValid
    }
    
    func getBookingData() {
        apiServices?.getDataForBooking()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { data in
                self.model = data
                self.view?.reload()
            }, onFailure: { error in
                self.view?.showAlert(title: "Error", message: error.localizedDescription)
            }).disposed(by: disposeBag)
    }
}
