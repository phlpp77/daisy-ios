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

class FireStoreManagerEvent {
    
    private var db: Firestore
    private var meEvents: [EventModelObject] = []
    
    init() {
        db = Firestore.firestore()
    }
    
    
    
    func getEvents() -> [EventModelObject] {
        return meEvents
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


    
    func getMeEvents(completionHandler: @escaping (Bool) -> Void) {

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
    

    
    
    //im View einfügen
    //@StateObject private var FirestoreManagerEvent = fireStoreManagerEvent()
    //.onAppear(perform: {
    //firestoreMangerEvent.getUserEvent
    //})
    
}
    
