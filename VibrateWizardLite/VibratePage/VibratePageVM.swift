//
//  VibratePageVM.swift
//  VibrateWizardLite
//
//  Created by Consultant on 1/31/23.
//

import Foundation
import Combine

class VibratePageVM
{
    let myFirebaseAPI = FirebaseAPI()
    var subs = Set<AnyCancellable>()
    
    var buttonHeld = PassthroughSubject<(Bool, String), Never>()
    
    init()
    {
        buttonHeld.sink { (status, userID) in
            self.myFirebaseAPI.setUserBuzz(userID: userID, set: status)
        }.store(in: &subs)
    }
}
