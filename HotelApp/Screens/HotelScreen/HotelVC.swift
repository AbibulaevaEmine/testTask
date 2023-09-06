//
//  HotelVC.swift
//  HotelTest
//
//  Created by admin on 30.08.2023.
//

import UIKit

protocol PHotelVC: AnyObject {
    func reload()
    func showAlert(title: String, message: String)
}

enum HotelCellType: Int {
    case hotelHeader = 0
    case hotelInfo
    case buttonCell
}

final class HotelVC: BaseVC, PHotelVC {
    var vm: PHotelVM?
    
    override var navigationBarTitle: String? {
        "Отель"
    }
        
    override func viewDidLoad() {
        vm?.getData()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ofType: HotelHeaderCell.self)
        tableView.registerCell(ofType: HotelInfoCell.self)
        tableView.registerCell(ofType: ButtonCell.self)
    }
    
    func reload() {
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = HotelCellType(rawValue: indexPath.section) else {
            return UITableView.automaticDimension
        }
        switch cellType {
        case .hotelHeader:
            return 450
        case .hotelInfo:
            return 458
        case .buttonCell:
            return 88
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = AppColors.grayBackground.color
        return spacer
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = HotelCellType(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch cellType {
        case .hotelHeader:
            guard let cell = tableView.dequeueCell(ofType: HotelHeaderCell.self) else { return UITableViewCell()}
            guard let model = vm?.model else { return UITableViewCell() }
            cell.setup(hotelData: model)
            return cell
        case .hotelInfo:
            guard let cell = tableView.dequeueCell(ofType: HotelInfoCell.self) else { return UITableViewCell()}
            guard let model = vm?.model else { return UITableViewCell() }
            cell.setup(model: model)
            return cell
        case .buttonCell:
            guard let cell = tableView.dequeueCell(ofType: ButtonCell.self) else { return UITableViewCell()}
            cell.setup {
                self.navigationController?.pushViewController(HotelsListAssembler.assemble(name: self.vm?.model?.name ?? ""), animated: true)
            }
            return cell
        }
    }

    // MARK: - Navigation
}
