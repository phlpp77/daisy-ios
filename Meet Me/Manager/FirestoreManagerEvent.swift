//
//  FirestoreManagerEvent.swift
//  Meet Me
//
//  Created by Lukas Dech on 14.02.21.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class FireStoreManagerEvent {
    
    private var db: Firestore
    private var event: [EventModelObject] = []
    
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

    
    
//    func getUserEvent(completion: @escaping (Result<[EventModelObject]?, Error>) -> Void) {
//
//        guard let currentUser = Auth.auth().currentUser else {
//            return
//        }
//
//        db.collection("events")
//            .whereField("userId", isNotEqualTo: currentUser.uid)
//            .getDocuments() { (snapshot, error) in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    if let snapshot = snapshot {
//                        let events: [EventModelObject]? = snapshot.documents.compactMap { doc in
//                            var event = try? doc.data(as: EventModel.self)
//                            event?.eventId = doc.documentID
//                            if let event = event {
//                                return EventModelObject(eventModel: eventModel)
//                            }
//                            return event
//                        }
//
//                        completion(.success(events))
//                    }
//
//                }
//            }
//    }
    
    func getUserEvent(completionHandler: @escaping (Bool) -> Void) {

        guard let currentUser = Auth.auth().currentUser else {
            return
        }
         var flag = false
        db.collection("events")
            .whereField("userId", isEqualTo: currentUser.uid)
            .getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    flag = false
                    print(error.localizedDescription)
                } else {
                    
                    if let snapshot = snapshot {
                        let event: [EventModelObject]? = snapshot.documents.compactMap { doc in
                            var event = try? doc.data(as: EventModel.self)
                            event?.eventId = doc.documentID
                            if let event = event {
                                return EventModelObject(eventModel: event)
                            }
                            return nil
                            
                            
                        }
                        print("hey")
                        
                        flag = true
                        completionHandler(flag)
                        DispatchQueue.main.async {
                            self?.event = event!
                        }
                        
                    }

                }
            }
    
        
    }
    
    func getEvents() -> [EventModelObject] {
        return event
    }
    
    
    //im View einfügen
    //@StateObject private var FirestoreManagerEvent = fireStoreManagerEvent()
    //.onAppear(perform: {
    //firestoreMangerEvent.getUserEvent
    //})
    
}
    
