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
                    .collection("likedEvent")
                    .document("likedEvent").setData(["likedEvent": ["Platzhalter"]])
                    
                seal.fulfill(())
                    
                }
            }
        }
    
    func addLikeToEventArray(eventId: String) -> Promise<Void>{
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                throw Err("No User Profile")
            }
            
            do {
                let _ =  db.collection("users")
                    .document(currentUser.uid)
                    .collection("likedEvent")
                    .document("likedEvent")
                    .updateData(["likedEvent" : FieldValue.arrayUnion([eventId])])
                seal.fulfill(())
                    
                }
            }
        }
    
    func getAllLikedEvents() -> Promise<[String]> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                throw Err("No User Profile")
            }
            
            db.collection("users")
                .document(currentUser.uid)
                .collection("likedEvent")
                .document("likedEvent")
                .getDocument { (snapshot, error) in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        if let snapshot = snapshot {
                            let likedEvent = try? snapshot.data(as: LikedEvent.self)
                            if likedEvent != nil {
                                
                                DispatchQueue.main.async {
                                    if likedEvent?.likedEvent.count != 0 {
                                        seal.fulfill(likedEvent!.likedEvent)
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
    func getUserWhichCreatedEvent(eventModel: EventModelObject) -> Promise<UserModel> {
        return Promise { seal in
            db.collection("users").document(eventModel.userId).getDocument { snapshot, error in
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
}
    

    
  
    
   

