//
//  FirestoreManagerEvent.swift
//  Meet Me
//
//  Created by Lukas Dech on 14.02.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FireStoreManagerEvent {
    
    private var db: Firestore
    @Published var eventModel: [EventModelObject] = []
    
    init() {
        db = Firestore.firestore()
    }
    
    
    func saveEvent(eventModel: EventModel, completion: @escaping (Result<EventModel?, Error>) -> Void) {

        do {
            let ref = try db.collection("events").addDocument(from: eventModel)
            ref.getDocument { (snapshot, error) in
                guard let snapshot = snapshot, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                let eventModel = try? snapshot.data(as: EventModel.self)
                completion(.success(eventModel))
            }
        } catch let error {
                completion(.failure(error))
            }
        }
    
    
}
    
