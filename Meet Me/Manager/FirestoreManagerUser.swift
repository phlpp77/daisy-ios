//
//ProfileCreationModel.swift
//Meet Me
//
//Created by Lukas Dech on 29.01.21.
//
//
//Funktions Beschreibung
//
//- saveUser()
// saved ein Event Model zur collection User
// wird aufgerufen in --> EventCreationViewModel

//- getAllUsers()
// ladet alle Events des aktuellen Nutzers herunter und speichert alle im Array meEvents vom Typ EventModelObject
// wird aufgerufen in --> YouEventViewModel

//- getCurrentUserModel
// return das Array meEvents welches von getMeEvent() objekte bekommt
// wird aufgerufen in --> YouEventViewModel

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

class FirestoreManagerUser {
    
    private var db: Firestore
    private var currentUserModel: UserModel?
    
    
    init() {
        db = Firestore.firestore()
    }
    

    func saveUser(userModel: UserModel, completion: @escaping (Result<UserModel?, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.uid else {
            return
        }
        do {
            try db.collection("users").document(currentUser).setData(from: userModel)
            completion(.success(userModel))
        } catch let error {
            print("fail")
            completion(.failure(error))
        }
    }
    
    
    
    func getAllUsers(completion: @escaping (Result<[UserModel]?, Error>) -> Void) {

        guard let currentUser = Auth.auth().currentUser else {
            return
        }
      
        db.collection("users")
            .whereField("userId", isEqualTo: currentUser.uid)
            .getDocuments() { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let snapshot = snapshot {
                        let users: [UserModel]? = snapshot.documents.compactMap { doc in
                            var user = try? doc.data(as: UserModel.self)
                            if user != nil {
                                print("ALLUSER: \(snapshot)")
                                user!.userId = doc.documentID
                                print("ALLUSER: \(user!.userId)")
                            }
                            return user
                        }

                        completion(.success(users))
                    }

                }
            }
        
    }
    
    
    func downloadCurrentUserModel(completion: @escaping (Bool) -> Void) {
       
        var flag = false
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        db.collection("users").document(currentUser.uid).getDocument { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(flag)
            } else {
                if let snapshot = snapshot {
                    var userModel = try? snapshot.data(as: UserModel.self)
                    if userModel != nil {
                        userModel!.userId = snapshot.documentID
                    }

                        self.currentUserModel = userModel
                        print(currentUser)
                        flag = true
                        completion(flag)
                    }
                }
                
            }
            
            
        }
        

        
    
    
    

    
    func getCurrentUserModel() -> UserModel {
        print("called get current user Model")
        if currentUserModel != nil {
            return currentUserModel!
        } else {
            print("test user currentUserModel == nil")
            return testUser
        }
    }
    
    
    
    



}
