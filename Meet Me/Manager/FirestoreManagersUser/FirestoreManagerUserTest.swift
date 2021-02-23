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
    //private var currentUserModel: UserModel?
    
    
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
    
    // MARK: - Functions to Save userModel to Firebase
    func saveUser(userModel: UserModel) -> Promise<UserModel>{
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser?.uid else {
                throw Err("no current User")
            }
            do {
                try db.collection("users").document(currentUser).setData(from: userModel)
                seal.fulfill(userModel)
            } catch let error {
                print("fail")
                seal.reject(error)
            }
        }
    }
    
    // MARK: - Functions to Update current User
    
    
    
    
    
    // MARK: - Functions to get User Profiles
    
    func getAllUsers() -> Promise<[UserModel]>{
        return Promise { seal in
            
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            
            db.collection("users")
                .whereField("userId", isEqualTo: currentUser.uid)
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
                            DispatchQueue.main.async {
                                seal.fulfill(users!)
                            }
                            
                        }
                        
                    }
                }
            
        }
    }
    
    //Muss noch eingefügt werden
    func getUserWhichCreatedEvent(eventModel: EventModel) -> Promise<UserModel> {
        return Promise { seal in
            db.collection("users").document(eventModel.eventId).getDocument { snapshot, error in
                if let error = error {
                    seal.reject(error)
                } else {
                    if let snapshot = snapshot {
                        let userModel = try? snapshot.data(as: UserModel.self)
                        if userModel != nil{
                            seal.fulfill(userModel!)
                        }
                        
                    }
                }
            }
        }
    }
            
    
    func downloadCurrentUserModel() -> Promise<UserModel> {
        return Promise { seal in
            
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            db.collection("users").document(currentUser.uid).getDocument { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    seal.reject(error)
                } else {
                    if let snapshot = snapshot {
                        var userModel = try? snapshot.data(as: UserModel.self)
                        if userModel != nil {
                            userModel!.userId = snapshot.documentID
                        }
                        
                        seal.fulfill(userModel!)
                    }
                }
                
            }
            
            
        }
    }
    // MARK: - Functions to get add or delete a Match to User
    
    func addMatchToCurrentUser(userModel: UserModel) -> Promise<Void> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            let _ = db.collection("users")
                .document(currentUser.uid)
                .collection("matches").document(userModel.userId).setData(["userId": userModel.userId]) { error in
                    if let error = error {
                        seal.reject(error)
                    }
                }
            seal.fulfill(())
        }
        
    }
    
    
    func addMatchToMatchedUser(userModel: UserModel) -> Promise<Void> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            let _ = db.collection("users")
                .document(userModel.userId)
                .collection("matches").document(currentUser.uid).setData(["userId": currentUser.uid]) { error in
                    if let error = error {
                        seal.reject(error)
                    }
                }
            seal.fulfill(())
        }
    }
    
    func deleteLikedUser(eventModel: EventModel, userModel: UserModel) -> Promise<Void> {
        return Promise { seal in
            
            db.collection("events")
                .document(eventModel.eventId)
                .collection("likedUser")
                .document(userModel.userId).delete() { error in
                    if let error = error {
                        seal.reject(error)
                    }
                }
            seal.fulfill(())
        }
    }
    
    //Muss noch implementiert werden 
    func delteMatchFromUserProfile(userModel: UserModel) -> Promise<Void> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            db.collection("users")
                .document(currentUser.uid)
                .collection("matches")
                .document(userModel.userId).delete() { error in
                    if let error = error {
                        seal.reject(error)
                    }
                }
            seal.fulfill(())
        }
    }
    
    
    
}
