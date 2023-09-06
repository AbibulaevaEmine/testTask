//
//  BuyerInfoCell.swift
//  HotelApp
//
//  Created by admin on 03.09.2023.
//

import UIKit

final class BuyerInfoCell: UITableViewCell {
    @IBOutlet private weak var phoneTaxtField: UITextField!
    @IBOutlet private weak var emailTaxtField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        phoneTaxtField.delegate = self
        emailTaxtField.delegate = self
        setupTaxtField(textField: phoneTaxtField, placeholder: "Номер телефона")
        setupTaxtField(textField: emailTaxtField, placeholder: "Почта")
        phoneTaxtField.setPadding(left: 10, right: 10)
        emailTaxtField.setPadding(left: 10, right: 10)
    }
    
    private func setupTaxtField(textField: UITextField, placeholder: String) {
        textField.backgroundColor = AppColors.grayBackground.color
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.placeholder = placeholder
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func updateTextFieldBackgroundColor(textField: UITextField, isValid: Bool) {
        let errorColor = AppColors.errorColor.color
        textField.backgroundColor = (isValid) ? AppColors.grayBackground.color : errorColor
    }
}

extension BuyerInfoCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === phoneTaxtField && (textField.text!.isEmpty || textField.text == "+7 ") {
            textField.text = "+7 (***) ***-**-**"
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTaxtField {
            if isValidEmail(textField.text ?? "") {
                updateTextFieldBackgroundColor(textField: textField, isValid: true)
            } else {
                updateTextFieldBackgroundColor(textField: textField, isValid: false)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField === phoneTaxtField {
            let allowedCharacters = Set("0123456789")
            
            guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
            
            if string.isEmpty {
                var currentIndex = text.index(before: textRange.upperBound)
                
                while true {
                    if text[currentIndex].isNumber {
                        textField.text?.replaceSubrange(currentIndex...currentIndex, with: "*")
                        break
                    }
                    if currentIndex == textField.text!.startIndex {
                        break
                    }
                    currentIndex = textField.text!.index(before: currentIndex)
                }
                
                return false
            } else {
                let characters = Set(string)
                guard characters.isSubset(of: allowedCharacters) else { return false }
                
                if let nextPlaceholderIndex = textField.text?.range(of: "*") {
                    textField.text?.replaceSubrange(nextPlaceholderIndex, with: string)
                } else {
                    return false
                }
            }
            return false
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
