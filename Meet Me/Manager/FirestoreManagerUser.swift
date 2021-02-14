//
//  ProfileCreationModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 29.01.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirestoreManager {
    
    private var db: Firestore
    @Published var user: [UserModel] = []
    
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
    
    
    
    func getUserItem(completion: @escaping (Result<[UserModel]?, Error>) -> Void) {

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
//
//    func selectUserItems () {
//
//        guard let currentUser = Auth.auth().currentUser else {
//            return
//        }
//
//        db.collection("users")
//            .whereField("userId", isEqualTo: currentUser.uid)
//            .getDocuments { (snapshot, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                } else {
//
//                    if let snapshot = snapshot {
//                        let user: [MainSettingsView] = snapshot.documents.compactMap { doc in
//                            var user = try? doc.data(as: UserModel.self)
//                            user?.userId = doc.documentID
//                            if let user = user {
//                                return MainSettingsView(user: user)
//                            }
//                            return nil
//                        }
//
//                        DispatchQueue.main.async {
//                            self?.user = user
//                        }
//
//                    }
//                }
//
//            }
//    }
}

