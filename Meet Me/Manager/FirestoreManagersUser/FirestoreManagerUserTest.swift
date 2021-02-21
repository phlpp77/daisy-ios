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
    
    
    func getAllMatchedUsers(eventId: String) -> Promise<[UserModelObject]> {
        return Promise { seal in
            
            db.collection("events")
                .document(eventId)
                .collection("likedUser")
                .getDocuments() { (snapshot, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        seal.reject(error)
                    } else {
                        if let snapshot = snapshot {
                            let user: [UserModelObject] = snapshot.documents.compactMap { doc in
                                var user = try? doc.data(as: UserModel.self)
                                user?.userId = doc.documentID
                                if let user = user {
                                    return UserModelObject(user: user)
                                }
                                return nil
                                
                            }
                            DispatchQueue.main.async {
                            seal.fulfill(user)
                            }

                            }
                        }
                        
                    }
                }
            
        }
    }

