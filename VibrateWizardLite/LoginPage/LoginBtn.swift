//
//  LoginBtn.swift
//  VibrateWizardLite
//
//  Created by Consultant on 1/31/23.
//

import UIKit

class LoginBtn: UIButton
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure()
    {
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel?.text = "Login"
        backgroundColor = .systemBlue
        setTitle("Login", for: .normal)
    }
}
