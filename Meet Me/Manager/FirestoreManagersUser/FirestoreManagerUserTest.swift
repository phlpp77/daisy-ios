//
//  FirestoreManagerUserTest.swift
//  Meet Me
//
//  Created by Lukas Dech on 21.02.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth
import PromiseKit

class FirestoreManagerUserTest {
    
    private var db: Firestore
    private var currentUserModel: UserModel?
    
    
    init() {
        db = Firestore.firestore()
    }
    
    
    func getAllMatchedUsers(eventId: String) -> Promise<[UserModel]> {
        return Promise { seal in
            
            db.collection("events")
                .document(eventId)
                .collection("likedUser")
                .getDocuments() { (snapshot, error) in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        if let snapshot = snapshot {
                            let users: [UserModel]? = snapshot.documents.compactMap { doc in
                                var user = try? doc.data(as: UserModel.self)
                                if user != nil {
                                    user!.userId = doc.documentID
                                }
                                return user
                            }
                            if users?.isEmpty != true {
                                seal.fulfill(users!)
                            } else {
                                let error: Error = "DEBUG: Keine Matched User vorhanden" as! Error
                                print(error)
                                seal.reject(error)
                            }
                        }
                        
                    }
                }
            
        }
    }
}
