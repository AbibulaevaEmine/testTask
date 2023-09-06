//
//  TouristFullInfoCell.swift
//  HotelApp
//
//  Created by admin on 03.09.2023.
//

import UIKit

final class TouristFullInfoCell: UITableViewCell {
    @IBOutlet private weak var dataTextField: UITextField!
    @IBOutlet private weak var numberPassportTextField: UITextField!
    @IBOutlet private weak var nationalityTextField: UITextField!
    @IBOutlet private weak var birhdayTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTaxtField(textField: dataTextField, placeholder: "Срок действия загранпаспорта")
        setupTaxtField(textField: numberPassportTextField, placeholder: "Номер загранпаспорта")
        setupTaxtField(textField: nationalityTextField, placeholder: "Гражданство")
        setupTaxtField(textField: birhdayTextField, placeholder: "Дата рождения")
        setupTaxtField(textField: surnameTextField, placeholder: "Фамилия")
        setupTaxtField(textField: nameTextField, placeholder: "Имя")
        dataTextField.setPadding(left: 10, right: 10)
        numberPassportTextField.setPadding(left: 10, right: 10)
        nationalityTextField.setPadding(left: 10, right: 10)
        birhdayTextField.setPadding(left: 10, right: 10)
        surnameTextField.setPadding(left: 10, right: 10)
        nameTextField.setPadding(left: 10, right: 10)
    }
    
    private func setupTaxtField(textField: UITextField, placeholder: String) {
        textField.backgroundColor = AppColors.grayBackground.color
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.placeholder = placeholder
    }
    
    func validate() -> Bool {
        let textFields: [UITextField] = [nameTextField, surnameTextField,
                                         birhdayTextField, nationalityTextField,
                                         numberPassportTextField, dataTextField]
        let invalidFieldColor = AppColors.errorColor.color
        let validFieldColor = AppColors.grayColorText.color
        var isValid = true
        
        for textField in textFields {
            if textField.text?.isEmpty == true {
                textField.backgroundColor = invalidFieldColor
                isValid = false
            } else {
                textField.backgroundColor = validFieldColor
            }
        }
        
        return isValid
    }
}
