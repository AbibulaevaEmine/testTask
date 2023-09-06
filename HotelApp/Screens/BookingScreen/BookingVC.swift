//
//  BookingVC.swift
//  HotelApp
//
//  Created by admin on 02.09.2023.
//

import UIKit

protocol PBookingVC: AnyObject {
    func reload()
    func showAlert(title: String, message: String)
}

final class BookingVC: BaseVC, PBookingVC {
    var vm: PBookingVM?
    private var expandedRows: Set<Int> = []
    private var tourists: [String] = ["Первый турист"]
    private var index: [Int] = []
    override var navigationBarTitle: String? {
        "Бронирование"
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(ofType: HotelInformationCell.self)
        tableView.registerCell(ofType: BookingCell.self)
        tableView.registerCell(ofType: BuyerInfoCell.self)
        tableView.registerCell(ofType: PaymentCell.self)
        tableView.registerCell(ofType: TouristInfoCell.self)
        tableView.registerCell(ofType: TouristFullInfoCell.self)
        tableView.registerCell(ofType: PayButtonCell.self)
        tableView.registerCell(ofType: AddNewTouristCell.self)
        vm?.getBookingData()
    }
    
    func reload() {
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 + tourists.count + expandedRows.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 120
        } else if indexPath.row == 1 {
            return 312
        } else if indexPath.row == 2{
            return 232
        } else if indexPath.row == (6 + tourists.count + expandedRows.count) - 2 {
            return 156
        } else if indexPath.row == (6 + tourists.count + expandedRows.count) - 1 {
            return 88
        }  else if indexPath.row == (6 + tourists.count + expandedRows.count) - 3 {
            return 58
        } else {
            let i = (indexPath.row - 3) / 2
            
            if expandedRows.contains(i) {
                return (indexPath.row % 2 == 1) ? 58 : 372
            } else {
                return (indexPath.row % 2 == 1) ? 58 : 58
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueCell(ofType: HotelInformationCell.self) else { return UITableViewCell() }
            guard let model = vm?.model else { return UITableViewCell()}
            cell.setup(model: model)
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueCell(ofType: BookingCell.self) else { return UITableViewCell() }
            guard let model = vm?.model else { return UITableViewCell()}
            cell.setup(model: model)
            
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueCell(ofType: BuyerInfoCell.self) else { return UITableViewCell() }
            
            return cell
        } else if indexPath.row == (6 + tourists.count + expandedRows.count) - 3 {
            guard let cell = tableView.dequeueCell(ofType: AddNewTouristCell.self) else { return UITableViewCell() }
            
            cell.setup {
                let newTouristNumber = self.tourists.count
                let newTouristString = self.vm?.ordinalString(newTouristNumber)
                
                self.tourists.append(newTouristString ?? "Новый турист")
                self.tableView.reloadData()
            }
            
            return cell
        } else if indexPath.row == (6 + tourists.count + expandedRows.count) - 2 {
            guard let cell = tableView.dequeueCell(ofType: PaymentCell.self) else { return UITableViewCell() }
            guard let model = vm?.model else { return UITableViewCell()}
            cell.setup(model: model)
            
            return cell
        } else if indexPath.row == (6 + tourists.count + expandedRows.count) - 1 {
            guard let cell = tableView.dequeueCell(ofType: PayButtonCell.self) else { return UITableViewCell() }
            guard let model = vm?.model else { return UITableViewCell()}
            cell.setup(model: model, action: {
                if let validationResult = self.vm?.validateTouristInfo(touristsCount: self.tourists.count, tableView: tableView), validationResult {
                    self.navigationController?.pushViewController(FinishBookingVC(), animated: true)
                }
            })
            
            return cell
        } else {
            if indexPath.row % 2 == 0 {
                let i = (indexPath.row - 3) / 2
                if expandedRows.contains(i) {
                    guard let cell = tableView.dequeueCell(ofType: TouristFullInfoCell.self) else { return UITableViewCell() }
                    return cell
                } else {
                    return createTouristInfoCell(indexPath: indexPath, tableView: tableView)
                }
            } else {
                return createTouristInfoCell(indexPath: indexPath, tableView: tableView)
            }
        }
    }
    
    private func createTouristInfoCell(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(ofType: TouristInfoCell.self) else { return UITableViewCell() }
        let i = (indexPath.row - 3) / 2
        
        cell.setup(text: tourists[i], image: (expandedRows.contains(indexPath.row) ? AppAssets.openBtn.image : AppAssets.closeBtn.image) ?? UIImage(), action: {
            self.openTouristFullInfo(tableView: tableView, indexPath: indexPath)
        })
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openTouristFullInfo(tableView: tableView, indexPath: indexPath)
    }
    
    private func openTouristFullInfo(tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) as? TouristInfoCell {
            let i = (indexPath.row - 3) / 2
            
            if expandedRows.contains(i) {
                expandedRows.remove(i)
                tableView.beginUpdates()
                tableView.deleteRows(at: [IndexPath(row: indexPath.row + 1, section: indexPath.section)], with: .automatic)
                cell.updateImage(image: AppAssets.closeBtn.image ?? UIImage())
                tableView.endUpdates()
            } else {
                expandedRows.insert(i)
                tableView.beginUpdates()
                tableView.insertRows(at: [IndexPath(row: indexPath.row + 1, section: indexPath.section)], with: .automatic)
                cell.updateImage(image: AppAssets.openBtn.image ?? UIImage())
                tableView.endUpdates()
            }
        }
    }
    // MARK: - Navigation
}
