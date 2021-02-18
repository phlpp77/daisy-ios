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
        
    
    func currentUserModel(completion: @escaping (Result<UserModel?, Error>) -> Void) {
        
        guard let currentUser = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(currentUser).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                if let snapshot = snapshot {
                    let userModel = try? snapshot.data(as: UserModel.self)
                    if userModel != nil {
                        completion(.success(userModel))
                    }
                }
                
            }
            
            
        }
        
    }
    
    
    func saveCurrentUserModelToVariabel(){
        currentUserModel(completion: { success in
                switch success {
                case .success(let userModel):
                    DispatchQueue.main.async {
                        self.currentUserModel = userModel
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        print("Download User Failed")
                    }
                    
                
                }
            })
        }
    
    func getCurrentUserModel() -> UserModel {
        saveCurrentUserModelToVariabel()
        if currentUserModel != nil {
            return currentUserModel!
        } else {
            return testUser
        }
    }
    
    
    
    
}



