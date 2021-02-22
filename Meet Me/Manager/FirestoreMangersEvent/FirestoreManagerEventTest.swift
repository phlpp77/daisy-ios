
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
    private var meEvents: [EventModelObject] = []
    private var youEvents: [EventModelObject] = []
    private var createdID: String = UUID().uuidString
    private var currentUserModel = stockUser
    
    
    init() {
        db = Firestore.firestore()

    }
    
    func getID() -> String {
        return createdID
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

    func addLikeToEvent(eventId: String, userModel: UserModel) -> Promise<UserModel>{
        return Promise { seal in
            do {
                let _ = try db.collection("events")
                    .document(eventId)
                    .collection("likedUser").addDocument(from: userModel)
                seal.fulfill(userModel)
            } catch let error {
                seal.reject(error)
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
                        //print(error.localizedDescription)
                        seal.reject(error)
                    } else {
                        
                        if let snapshot = snapshot {
                            let event: [EventModelObject]? = snapshot.documents.compactMap { doc in
                                var event = try? doc.data(as: EventModel.self)
                                event?.eventId = doc.documentID
                                if let event = event {
                                    // Philipp added the .constant to handle the error of the needed position
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
                let error: Error = "No current User" as! Error
                seal.reject(error)
                return
            }
        
            
            db.collection("events")
                .whereField("userId", isNotEqualTo: currentUser.uid)
                .getDocuments {(snapshot, error) in
                    if let error = error {
                        //print(error.localizedDescription)
                        seal.reject(error)
                    } else {
                        
                        if let snapshot = snapshot {
                            let event: [EventModelObject]? = snapshot.documents.compactMap { doc in
                                var event = try? doc.data(as: EventModel.self)
                                event?.eventId = doc.documentID
                                if let event = event {
                                    // Philipp added the .constant to handle the error of the needed position
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
    


        
 

    

