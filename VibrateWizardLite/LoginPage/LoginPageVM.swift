//
//  LoginPageVM.swift
//  VibrateWizardLite
//
//  Created by Consultant on 1/31/23.
//

import Foundation
import Combine

class LoginPageVM
{
    let vm = FirebaseAPI()
    var subs = Set<AnyCancellable>()
    
    var email = PassthroughSubject<String, Never>()
    var password = PassthroughSubject<String, Never>()
    var loginStatus = PassthroughSubject<Bool, Never>()
    
    init()
    {
        setupEmailAndPassword()
    }
    
    func setupEmailAndPassword()
    {
        email.combineLatest(password)
            .map { (theEmail, thePassword) -> AnyPublisher<Bool, Never> in
                return self.vm.validateCredentials(email: theEmail, password: thePassword).eraseToAnyPublisher()
            }
            .switchToLatest()
            .sink { status in
                self.loginStatus.send(status)
            }.store(in: &subs)
    }
}
