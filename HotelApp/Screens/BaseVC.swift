//
//  BaseVC.swift
//  HotelApp
//
//  Created by admin on 05.09.2023.
//

import Foundation
import UIKit

class BaseVC: UITableViewController {
    var isNavigationBarHidden: Bool {
        false
    }
    
    var navigationBarTitle: String? { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: false)
        title = navigationBarTitle
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
