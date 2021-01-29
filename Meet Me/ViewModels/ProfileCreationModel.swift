//
//  ProfileCreationModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 29.01.21.
//

import Foundation
import Firebase
//import FirebaseFirestoreSwift

class ProfileCreationModel {
    
    private var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func save(userModel: UserModel, completion: @escaping (Result<UserModel?, Error>) -> Void) {
        
        do {
            let ref = try db.collection("users").addDocument(from: userModel)
            ref.getDocument { (snapshot, error) in
                guard let snapshot = snapshot, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                let store = try? snapshot.data(as: UserModel.self)
                completion(.succes(stoe))
            }
        } catch let error {
                completion(.failure(error))
            }
        }
    }

