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
    
    func createLikedEventsArray() -> Promise<Void>{
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            do {
                let _ =  db.collection("users")
                    .document(currentUser.uid)
                    .collection("likedEvents")
                    .document("likedEvents").setData(["likedEvens": []])
                    
                seal.fulfill(())
                    
                }
            }
        }
    
    // MARK: - Functions to Update current User
    
    
    
    
    
    // MARK: - Functions to get User Profiles
    
    func getCurrentUser() -> Promise<UserModel> {
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
                        let userModel = try? snapshot.data(as: UserModel.self)
                        DispatchQueue.main.async {
                            if userModel != nil {
                                seal.fulfill(userModel!)
                            }else {
                                let err = Err("userModel")
                                seal.reject(err)
                            }
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
                        DispatchQueue.main.async {
                            if userModel != nil{
                                seal.fulfill(userModel!)
                            } else {
                                let error = Err("Cant get UserProfil from Creator")
                                seal.reject(error)
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    func getAllLikedUserDocument(eventId: String) -> Promise<[String]> {
        return Promise { seal in
            
            db.collection("events")
                .document(eventId)
                .collection("likedUser")
                .document("likedUser")
                .getDocument { (snapshot, error) in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        if let snapshot = snapshot {
                            let likedUser = try? snapshot.data(as: LikedUser.self)
                            if likedUser != nil {
                                
                                DispatchQueue.main.async {
                                    if likedUser?.likedUser.count != 0 {
                                        seal.fulfill(likedUser!.likedUser)
                                } else {
                                    let error = Err("No Liked Availibale")
                                    seal.reject(error)
                                }
                            }
                            }
                            
                        }
                        
                        
                    }
                }
        }
    }
    
    
    func getAllLikedUserModels(likedUser: [String]) -> Promise<[UserModelObject]> {
        return Promise { seal in
            print(likedUser)
            db.collection("users")
                .whereField("userId", in: likedUser)
                .getDocuments {(snapshot, error) in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        
                        if let snapshot = snapshot {
                            let userModel: [UserModelObject] = snapshot.documents.compactMap { doc in
                                let userModel = try? doc.data(as: UserModel.self)
                                if let userModel = userModel {
                                    return UserModelObject(user: userModel)
                                }
                                return nil
                                
                            }
                            DispatchQueue.main.async {
                                print(userModel)
                                seal.fulfill(userModel)
                            }
                            
                        }
                        
                    }
                }
            
            
        }
    }
    
    // MARK: -Funtion to add like to Event to UserProfil
    
    func addLikedEventToCurrentUser(eventId: String) -> Promise<Void> {
        return Promise { seal in
            
            
        }
        
    }
    
    
    

    
    
    
    // MARK: - Functions to get add a Match to User
    
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
    
    // MARK: -  delete a like from User
    
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
    func deleteMatchFromUserProfile(userModel: UserModel) -> Promise<Void> {
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
