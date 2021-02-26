
//
//FirestoreManagerEvent.swift
//Meet Me
//
//Created by Lukas Dech on 14.02.21.
//
//
//Funktions Beschreibung
//
//- saveEvent()
// saved ein Event Model zur collection User
// wird aufgerufen in --> EventCreationViewModel

//- getMeEvents()
// ladet alle Events des aktuellen Nutzers herunter und speichert alle im Array meEvents vom Typ EventModelObject
// wird aufgerufen in --> YouEventViewModel

//-getEvents
// return das Array meEvents welches von getMeEvent() objekte bekommt
// wird aufgerufen in --> YouEventViewModel

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth
import PromiseKit

class FireStoreManagerEventTest {
    
    private var db: Firestore

    
    init() {
        db = Firestore.firestore()

    }
    
    
    // MARK: - Functions to Save events to Firebase

    
    func saveEvent(eventModel: EventModel, eventId: String) -> Promise<Void> {
        return Promise { seal in
        do {
            try db.collection("events").document(eventId).setData(from: eventModel)
            seal.fulfill(())
            }
        catch let error{
            seal.reject(error)
        }
    }
}

    // MARK: - Functions to update events
    
    func createLikedUserArray(eventId: String) -> Promise<Void>{
        return Promise { seal in
            do {
                let _ =  db.collection("events")
                    .document(eventId)
                    .collection("likedUser")
                    .document("likedUser").setData(["likedUser": []])
                    
                seal.fulfill(())
                    
                }
            }
        }

    func addLikeToEventArray(eventId: String, userModel: UserModel) -> Promise<UserModel>{
        return Promise { seal in
            do {
                let _ =  db.collection("events")
                    .document(eventId)
                    .collection("likedUser")
                    .document("likedUser")
                    .updateData(["likedUser" : FieldValue.arrayUnion([userModel.userId])])
                seal.fulfill(userModel)
                    
                }
            }
        }
    


    // MARK: - Functions to get events
    func firebaseGetMeEvents() -> Promise<[EventModelObject]> {
        return Promise { seal in
            
            guard let currentUser = Auth.auth().currentUser else {
                let error: Error = "No current User" as! Error
                seal.reject(error)
                return
            }
        
            
            db.collection("events")
                .whereField("userId", isEqualTo: currentUser.uid)
                .getDocuments {(snapshot, error) in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        
                        if let snapshot = snapshot {
                            let event: [EventModelObject]? = snapshot.documents.compactMap { doc in
                                var event = try? doc.data(as: EventModel.self)
                                event?.eventId = doc.documentID
                                if let event = event {
                                    return EventModelObject(eventModel: event, position: .constant(CGSize.zero))
                                }
                                return nil
                                
                            }
                            DispatchQueue.main.async {
                                seal.fulfill(event!)
                            }
                            
                        }
                        
                    }
                }
            
            
        }
    }

    // MARK: - Functions to get events
    func firebaseGetYouEvents() -> Promise<[EventModelObject]> {
        return Promise { seal in
            
            guard let currentUser = Auth.auth().currentUser else {
                throw Err("No User Profile")
            }
        
            
            db.collection("events")
                .whereField("userId", isNotEqualTo: currentUser.uid)
                .getDocuments {(snapshot, error) in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        
                        if let snapshot = snapshot {
                            let event: [EventModelObject]? = snapshot.documents.compactMap { doc in
                                var event = try? doc.data(as: EventModel.self)
                                event?.eventId = doc.documentID
                                if let event = event {
                                    return EventModelObject(eventModel: event, position: .constant(CGSize.zero))
                                }
                                return nil
                                
                            }
                            DispatchQueue.main.async {
                                seal.fulfill(event!)
                            }
                            
                        }
                        
                    }
                }
            
            
        }
    }
}
    


        
 

    

