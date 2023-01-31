//
//  EmailTextField.swift
//  VibrateWizardLite
//
//  Created by Consultant on 1/31/23.
//

import UIKit

class CredentialsTextField: UITextField
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String, isSecure: Bool = false)
    {
        super.init(frame: .zero)
        self.placeholder = placeholder
        isSecureTextEntry = isSecure
        configure()
    }
    
    private func configure()
    {
        layer.cornerRadius = 10
        textAlignment = .left
        //placeholder = "Email"
        font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemPurple.cgColor
        textColor = .label
        tintColor = .label
        //adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        autocorrectionType = .no
        backgroundColor = .white
        autocapitalizationType = .none
    }
    
    let textPadding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rec = super.textRect(forBounds: bounds)
        return rec.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rec = super.editingRect(forBounds: bounds)
        return rec.inset(by: textPadding)
    }
    

}
