//
//  FirebaseAPI.swift
//  VibrateWizardLite
//
//  Created by Consultant on 1/31/23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class FirebaseAPI
{
    let db = Firestore.firestore()
    var subs = Set<AnyCancellable>()
}

// Login Page
extension FirebaseAPI
{
    func validateCredentials(email: String, password: String) -> Future<Bool, Never>
    {
        return Future { promise in
            Auth.auth().signIn(withEmail: email, password: password)
            {
                authDataResult, error in
                if let error
                {
                    let authError = error as! AuthErrorCode
                    switch authError.code
                    {
                    case .wrongPassword:
                        print("Wrong Password")
                    case .invalidEmail:
                        print("malformed email")
                    case .userNotFound:
                        print("Email not in database")
                    default:
                        print(authError.localizedDescription + "\nError Code: \(authError.errorCode)")
                    }
                    promise(.success(false))
                } else if let authDataResult {
                    print("Logined in with: \(authDataResult.user.email!)")
                    promise(.success(true))
                }
            }
        }
    }
}

// Contacts Page

extension FirebaseAPI
{
    func getAllContacts(userID: String) -> Future<[User], Never>
    {
        return Future { promise in
            self.db.collection("User").whereField("userID", isEqualTo: userID).getDocuments
            {
                snapshot, error in
                guard let snapshot else {print(error!.localizedDescription); return}
                precondition(snapshot.documents.count == 1, "Should only find one document on the userID")
                let refPath = snapshot.documents[0]["contactRefPath"] as! String
                self.db.collection(refPath).getDocuments(completion: { snapshot, error in
                    guard let snapshot else {print(error!.localizedDescription); return}
                    
                    self.getUser(userID: snapshot.documents[0]["userID"] as! String)
                        .merge(with: self.getUser(userID: snapshot.documents[1]["userID"] as! String))
                        .reduce([User]()) { accum, next in
                            var res = accum
                            res.append(next)
                            return res
                        }.sink { allUserContacts in
                            promise(.success(allUserContacts))
                        }.store(in: &self.subs)
                })
            }
        }
    }
    
    func getUser(userID: String) -> Future<User, Never>
    {
        return Future { [weak self] promise in
            self?.db.collection("User").whereField("userID", isEqualTo: userID).getDocuments(completion: {
                snapshot, error in
                guard let snapshot else {print(error!.localizedDescription); return}
                precondition(snapshot.documents.count == 1, "Should only find one document on the userID")
                let userInfo = try! snapshot.documents[0].data(as: User.self)
                promise(.success(userInfo))
            })
        }
    }
}

// Vibrate Page
extension FirebaseAPI
{
    func setUserBuzz(userID: String, set: Bool)
    {
        self.db.collection("User").whereField("userID", isEqualTo: userID).getDocuments { snapshot, error in
            guard let snapshot else {print(error!.localizedDescription); return}
            snapshot.documents[0].reference.updateData(["Buzz" : set])
        }
    }
}

// General
extension FirebaseAPI
{
    func getUserBuzz(userID: String) -> Future<Bool, Never>
    {
        return Future { promise in
            self.db.collection("User").whereField("userID", isEqualTo: userID).getDocuments { snapshot, error in
                guard let snapshot else {print(error!.localizedDescription); return}
                let BuzzStatus = snapshot.documents[0]["Buzz"] as! Bool
                promise(.success(BuzzStatus))
            }
        }
    }
}
