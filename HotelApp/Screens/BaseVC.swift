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
    
    private func setupLabel(text: String?) {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.numberOfLines = 5
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: false)
        setupLabel(text: navigationBarTitle)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
