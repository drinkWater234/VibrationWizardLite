//
//  ContactsTableVM.swift
//  VibrateWizardLite
//
//  Created by Consultant on 1/31/23.
//

import Foundation
import Combine
import FirebaseAuth

class ContactsTableVM
{
    var subs = Set<AnyCancellable>()
    let myFirebaseAPI = FirebaseAPI()
    
    var allContacts = CurrentValueSubject<[User], Never>([User]())
    
    init()
    {
        myFirebaseAPI.getAllContacts(userID: Auth.auth().currentUser!.uid)
            .sink { contacts in
                self.allContacts.send(contacts)
            }.store(in: &self.subs)
    }
}
