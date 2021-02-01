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
    }

