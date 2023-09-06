//
//  HotelInfoCell.swift
//  HotelApp
//
//  Created by admin on 31.08.2023.
//

import UIKit

final class HotelInfoCell: BaseTableCell {
    @IBOutlet private weak var advantagesView: UIStackView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var backgroundTableView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundTableView.layer.cornerRadius = 5
        advantagesView.axis = .vertical
        advantagesView.alignment = .leading
        advantagesView.distribution = .fillEqually
        advantagesView.spacing = 8
        advantagesView.removeAllSubviews()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ofType: UsabilityCell.self)
    }
    
    func setup(model: HotelDTO) {
        setupLabels(count: model.aboutTheHotel.peculiarities, includeStackView: advantagesView, maxLineWidth: 350)
        descriptionLabel.text = model.aboutTheHotel.description
        descriptionLabel.sizeToFit()
    }
}

extension HotelInfoCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iconArray = [AppAssets.emojiHappy.image, AppAssets.tickSquare.image, AppAssets.closeSquare.image]
        let textArray = [AppText.comfort.rawValue, AppText.include.rawValue, AppText.notInclude.rawValue]
        guard let cell = tableView.dequeueCell(ofType: UsabilityCell.self) else { return UITableViewCell()}
        cell.setup(icon: iconArray[indexPath.row] ?? UIImage(), category: textArray[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
