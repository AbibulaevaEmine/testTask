//
//  HotelsListVC.swift
//  HotelApp
//
//  Created by admin on 31.08.2023.
//

import UIKit

protocol PHotelsListVC: AnyObject {
    var model: HotelRoomsWrapper? { get set }
    func reload()
    func showAlert(title: String, message: String)
}

final class HotelsListVC: BaseVC, PHotelsListVC {
    var vm: PHotelsListVM?
    var model: HotelRoomsWrapper?
    var name: String?
    
    override var navigationBarTitle: String? {
        name
    }
    
    override func viewDidLoad() {
        vm?.getDataAboutRooms()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ofType: HotelsListCell.self)
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let roomsCount = model?.rooms.count else { return 0 }
        return roomsCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 539
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        guard let cell = tableView.dequeueCell(ofType: HotelsListCell.self) else { return UITableViewCell() }
        guard let rooms = model?.rooms else { return UITableViewCell()}
        cell.setup(model: rooms[indexPath.section], actionForBtn: {
            self.navigationController?.pushViewController(BookingAssembler.assemble(), animated: true)
        })
        
        return cell
    }
    
    // MARK: - Navigation
}
