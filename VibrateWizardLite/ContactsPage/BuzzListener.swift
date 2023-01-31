//
//  BuzzListener.swift
//  VibrateWizardLite
//
//  Created by Consultant on 1/31/23.
//

import Foundation
import Combine
import FirebaseFirestore
import UIKit

class BuzzListener: Thread
{
    let myFirebaseAPI = FirebaseAPI()
    let db = Firestore.firestore()
    let userID: String
    var subs = Set<AnyCancellable>()
    var myTimer: Timer?
    var toggle = false
    var docListener: ListenerRegistration!
    
    init(userID: String) {
        self.userID = userID
        
        super.init()
        
        
    }
    
    override func main()
    {
        //print(userID)
        docListener = db.collection("User").whereField("userID", isEqualTo: userID).addSnapshotListener {
            snapshot, error in
            guard let snapshot else {print(error!.localizedDescription); return}
            snapshot.documentChanges.forEach { diff in
                if diff.type == .modified
                {
                    if !self.toggle
                    {
                        self.onVibrate()
                    } else {
                        self.stopVibrate()
                    }
                }
            }
        }

        
    }
    
    
    func onVibrate()
    {
        guard myTimer == nil else {return}
        myTimer = Timer(timeInterval: TimeInterval(100.0),
                        target: self,
                        selector: #selector(vibratePhone),
                        userInfo: nil, repeats: true)
    }
    
    @objc
    func vibratePhone()
    {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        print("Vibrating...")
        generator.impactOccurred()
    }
    
    func stopVibrate()
    {
        DispatchQueue.main.sync {
            print("stop vibrating")
        }
        
        myTimer?.invalidate()
        myTimer = nil
    }
    
    
}
