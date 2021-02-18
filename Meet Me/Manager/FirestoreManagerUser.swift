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
    
    //wird aktuell nicht verwendet variable ist im Meet_MeAppVM drin muss noch geändert werden
    //muss in ProfilMNodelObject geändert werden
    //@Published var users: [MeProfilModel] = []
    
    init() {
        db = Firestore.firestore()
    }
    
    
    
    
    
    func saveUser(userModel: UserModel, completion: @escaping (Result<UserModel?, Error>) -> Void) {

        do {
            let ref = try db.collection("users").addDocument(from: userModel)
            ref.getDocument { (snapshot, error) in
                guard let snapshot = snapshot, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                let userModel = try? snapshot.data(as: UserModel.self)
                completion(.success(userModel))
            }
        } catch let error {
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
                                user!.userId = doc.documentID
                            }
                            return user
                        }

                        completion(.success(users))
                    }

                }
            }
        
    }
        
    
    func downloadcurrentUserModel(completion: @escaping (Bool) -> Void) {
        test()
        var flag = false
        print("called currentUserModel")
        guard let currentUser = Auth.auth().currentUser?.uid else {
            print("current user not exist")
            return
        }
        
        db.collection("users").document("VXNj3PEdYsMpfiIAGxneS7dGHau2").getDocument { snapshot, error in
            print("conclusion handler")
            if let error = error {
                print(error.localizedDescription)
                completion(flag)
                print("didnt get user")
            } else {
                print("no error")
                if let snapshot = snapshot {
                    print("haave snapshot")
                    print(snapshot)
                    let userModel = try? snapshot.data(as: UserModel.self)
                    //userModel!.userId = snapshot.documentID
                    print(userModel)
                        
                        self.currentUserModel = userModel
                        print(currentUser)
                        flag = true
                        completion(flag)
                        print("Got USer")
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
