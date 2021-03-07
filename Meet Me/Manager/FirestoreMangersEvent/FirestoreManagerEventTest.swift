
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

class FirestoreManagerEventTest {
    
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

    func addLikeToEventArray(eventId: String) -> Promise<Void>{
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                throw Err("No User Profile")
            }
            
            do {
                let _ =  db.collection("events")
                    .document(eventId)
                    .collection("likedUser")
                    .document("likedUser")
                    .updateData(["likedUser" : FieldValue.arrayUnion([currentUser.uid])]){ error in
                        if let error = error {
                            seal.reject(error)
                        } else {
                            seal.fulfill(())
                        }
                    }
                
                
            }
        }
    }
    
    func setLikedUserToTrue(eventId: String) -> Promise<Void> {
        return Promise{ seal in
            let _ = db.collection("events").document(eventId).updateData(["likedUser": true]) { error in
                if let error = error {
                    seal.reject(error)
                }else {
                    seal.fulfill(())
                }
            }
        }
    }
    
    func setEventMatchedToTrue(eventId: String) -> Promise<Void> {
        return Promise{ seal in
            let _ = db.collection("events").document(eventId).updateData(["eventMatched": true]) { error in
                if let error = error {
                    seal.reject(error)
                }else {
                    seal.fulfill(())
                }
            }
        }
    }
    
    
    

    
    // MARK: - Functions to get events
    func firebaseGetYouEvents(likedEvents : [String]) -> Promise<[EventModelObject]> {
        return Promise { seal in
            
            guard let currentUser = Auth.auth().currentUser else {
                throw Err("No User Profile")
            }
            
            db.collection("events").whereField("eventMatched", isEqualTo: false)
                .getDocuments{(snapshot, error) in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        
                        if let snapshot = snapshot {
                            var event: [EventModelObject]? = snapshot.documents.compactMap { doc in
                                var event = try? doc.data(as: EventModel.self)
                                event?.eventId = doc.documentID
                                if let event = event {
                                    if event.userId != currentUser.uid {
                                        return EventModelObject(eventModel: event, position: .constant(CGSize.zero))
                                    }
                                }
                                return nil
                                
                            }
                            if event != nil {
                                for (index, eventModel) in event!.enumerated().reversed() {
                                    if likedEvents.contains(eventModel.eventId) {
                                            event!.remove(at: index)
                                    }
                                }
                                DispatchQueue.main.async {
                                    seal.fulfill(event!)
                                }
                            } else {
                                let error = Err("No Events in GetYouEvents")
                                DispatchQueue.main.async {
                                    seal.reject(error)
                                }
                            }
                        }
                        
                        
                        
                    }
                }
            
            
        }
    }
    
    func getAllLikedUserDocument(eventId: String) -> Promise<[String]> {
        return Promise { seal in
            
            db.collection("events")
                .document(eventId)
                .collection("likedUser")
                .document("likedUser")
                .getDocument { (snapshot, error) in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        if let snapshot = snapshot {
                            let likedUser = try? snapshot.data(as: LikedUser.self)
                            if likedUser != nil {
                                
                                DispatchQueue.main.async {
                                    if likedUser?.likedUser.count != 0 {
                                        seal.fulfill(likedUser!.likedUser)
                                } else {
                                    let error = Err("No Liked Availibale")
                                    seal.reject(error)
                                }
                            }
                            }
                            
                        }
                        
                        
                    }
                }
        }
    }
    
    
    func getAllLikedUserModels(likedUser: [String]) -> Promise<[UserModelObject]> {
        return Promise { seal in
            db.collection("users")
                .whereField("userId", in: likedUser)
                .getDocuments {(snapshot, error) in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        
                        if let snapshot = snapshot {
                            let userModel: [UserModelObject] = snapshot.documents.compactMap { doc in
                                let userModel = try? doc.data(as: UserModel.self)
                                if let userModel = userModel {
                                    return UserModelObject(user: userModel)
                                }
                                return nil
                                
                            }
                            DispatchQueue.main.async {
                                seal.fulfill(userModel)
                            }
                            
                        }
                        
                    }
                }
            
            
        }
    }
}
    


        
 

    

