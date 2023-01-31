//
//  ViewController.swift
//  VibrateWizardLite
//
//  Created by Consultant on 1/31/23.
//

import UIKit
import Combine

class LoginPageVC: UIViewController {
    
    let vm = LoginPageVM()
    var subs = Set<AnyCancellable>()
    
    let loginBtn = LoginBtn()
    let emailTextField = CredentialsTextField(placeholder: "Email", isSecure: false)
    let passwordTextField = CredentialsTextField(placeholder: "Password", isSecure: true)
    let logoImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPurple
        
        configLogoImage()
        configEmailTextField()
        configPasswordTextField()
        configLoginBtn()
        
        vm.loginStatus.sink { status in
            if status
            {
                self.navigationController?.pushViewController(ContactsTableVC(), animated: true)
            } else {
                print("Login Failed. Try Again")
            }
        }.store(in: &subs)
    }
    
    let titleFont = [
        NSAttributedString.Key.foregroundColor: UIColor.systemYellow,
        NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 24)!
    ]
    
    @objc
    func loginBtnClicked()
    {
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: nil, action: nil)
        vm.email.send(emailTextField.text!)
        vm.password.send(passwordTextField.text!)
        
        //navigationController?.pushViewController(ContactsTableVC(), animated: true)
    }
    
    func configLoginBtn()
    {
        view.addSubview(loginBtn)
        NSLayoutConstraint.activate([
            loginBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        loginBtn.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
    }
    
    func configPasswordTextField()
    {
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configEmailTextField()
    {
        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 48),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configLogoImage()
    {
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "wizard")!
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 300),
            logoImage.widthAnchor.constraint(equalToConstant: 300)
        ])
    }


}

