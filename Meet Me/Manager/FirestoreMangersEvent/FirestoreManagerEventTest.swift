
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
    init() {
        db = Firestore.firestore()

    }
    
    
    
    func getMeEvents() -> [EventModelObject] {
        print(meEvents)
        return meEvents
    }
    
    func getYouEvents()-> [EventModelObject] {
        print(youEvents)
        return youEvents
    }
    
    func getID() -> String {
        return createdID
    }
    
    
    
    // MARK: - Functions to Save events to Firebase

    
    func saveEvent(eventModel: EventModel) -> Promise<EventModel> {
        return Promise { seal in
            try db.collection("events").document(createdID).setData(from: eventModel)
            seal.fulfill(eventModel)
        } catch var error {
            print("fail")
            seal.reject(error)
        }
    }

    // MARK: - Functions to update events
    
    func addLikeToEvent(eventId: String, userModel: UserModel, completion: @escaping (Result<EventModel?, Error>) -> Void){
        
        do {
            let _ = try db.collection("events")
                    .document(eventId)
                    .collection("likedUser").addDocument(from: userModel)
        } catch let error {
            completion(.failure(error))
        }
    }

    // MARK: - Functions to get events
    func firebaseGetMeEvents(completionHandler: @escaping (Bool) -> Void) {

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
                                // Philipp added the .constant to handle the error of the needed position
                                return EventModelObject(eventModel: event, position: .constant(CGSize.zero))
                            }
                            return nil
                        
                        }
                        flag = true
                        completionHandler(flag)
                        DispatchQueue.main.async {
                            self?.meEvents = event!
                        }
                        
                    }

                }
            }
    
        
    }
    
    func firebaseGetYouEvents(completionHandler: @escaping (Bool) -> Void) {

        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        var flag = false
        db.collection("events")
            .whereField("userId", isNotEqualTo: currentUser.uid)
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
                                // Philipp added the .constant to handle the error of the needed position
                                return EventModelObject(eventModel: event, position: .constant(CGSize.zero))
                            }
                            return nil
                        
                        }
                        flag = true
                        completionHandler(flag)
                        DispatchQueue.main.async {
                            self?.youEvents = event!
                        }
                        
                    }

                }
            }
    
        
    }
    
}
    
