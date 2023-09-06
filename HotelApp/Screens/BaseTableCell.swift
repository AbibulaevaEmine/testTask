//
//  BaseTableCell.swift
//  HotelApp
//
//  Created by admin on 05.09.2023.
//

import Foundation
import UIKit

class BaseTableCell: UITableViewCell {
    private var setupLabel: UILabel {
        get {
            let optionLabel = UILabel()
            optionLabel.frame.size.height = 20
            optionLabel.numberOfLines = 1
            optionLabel.textColor = .gray
            optionLabel.textAlignment = .center
            optionLabel.layer.cornerRadius = 5
            optionLabel.clipsToBounds = true
            optionLabel.font = .systemFont(ofSize: 16)
            return optionLabel
        }
    }
    
    func updateRatingLabel(text: String, label: UILabel) {
        let image = AppAssets.starIcon.image
        let textAttachment = NSTextAttachment()
        textAttachment.image = image
        textAttachment.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
        
        let fontHeight = UIFont.systemFont(ofSize: label.font.pointSize).capHeight
        let imageHeight = CGFloat(15)
        let yOffset = (imageHeight - fontHeight) / 2
        
        textAttachment.bounds = CGRect(x: 0, y: -yOffset, width: 15, height: 15)
        
        let attrStringWithImage = NSMutableAttributedString(attachment: textAttachment)
        let attrStringWithText = NSMutableAttributedString(string: " \(text)")
        
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(attrStringWithImage)
        fullAttributedString.append(attrStringWithText)
        
        label.attributedText = fullAttributedString
        label.layer.masksToBounds = true
    }
    
    func convertToPrice(number: Int, prefix: String = "") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        
        let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) ?? ""
        
        let finalString = "\(prefix)\(formattedNumber) ₽"
        return finalString
    }
    
    private func addHorizontalStackView(includeStackView: UIStackView) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        includeStackView.addArrangedSubview(stackView)
        return stackView
    }
    
    func setupLabels(count: [String], includeStackView: UIStackView, maxLineWidth: CGFloat = 340) {
        let labelSpacing: CGFloat = 8
        
        var currentHorizontalStackView = addHorizontalStackView(includeStackView: includeStackView)
        var currentLabelWidth: CGFloat = 0
        for advantage in count {
            let label = setupLabel
            label.text = advantage
            label.sizeToFit()
            label.backgroundColor = .lightGray.withAlphaComponent(0.1)
            
            let labelWithSpacing = label.frame.width + labelSpacing
            if currentLabelWidth + labelWithSpacing > maxLineWidth {
                currentHorizontalStackView = addHorizontalStackView(includeStackView: includeStackView)
                currentLabelWidth = 0
            }
            
            currentHorizontalStackView.addArrangedSubview(label)
            currentLabelWidth += labelWithSpacing
        }
    }
}
