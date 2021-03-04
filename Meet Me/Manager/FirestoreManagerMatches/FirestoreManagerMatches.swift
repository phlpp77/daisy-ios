//
//  FirestoreManagerMatches.swift
//  Meet Me
//
//  Created by Lukas Dech on 27.02.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth
import PromiseKit

class FirestoreManagerMatches {
    
    private var db: Firestore
    //private var currentUserModel: UserModel?
    
    
    init() {
        db = Firestore.firestore()
    }
    
    // MARK: - Functions executed by Match
    
    func addMatchToCurrentUser(userModel: UserModelObject, eventModel: EventModelObject, chatId: String) -> Promise<Void> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            let eventId = UUID().uuidString
            let matchModel = MatchModel(chatId: chatId, eventId: eventModel.eventId, matchedUserId: userModel.userId)
            do {
                let _ = try db.collection("users")
                    .document(currentUser.uid)
                    .collection("matches").document(eventId).setData(from: matchModel) { error in
                        if let error = error {
                            seal.reject(error)
                        }
                        
                    }
            } catch { let error = error
                seal.reject(error)
            }
            seal.fulfill(())
        }
        
    }
    
    func addMatchToMatchedUser(userModel: UserModelObject,eventModel: EventModelObject, chatId: String) -> Promise<Void> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            let eventId = UUID().uuidString
            let matchModel = MatchModel(chatId: chatId, eventId: eventModel.eventId, matchedUserId: currentUser.uid)
            do {
                let _ = try db.collection("users")
                    .document(userModel.userId)
                    .collection("matches").document(eventId).setData(from: matchModel) { error in
                        if let error = error {
                            seal.reject(error)
                        }
                    }
            } catch { let error = error
                seal.reject(error)
            }
            seal.fulfill(())
        }
    }
    
    func createChatRoom(userModel: UserModelObject, eventModel: EventModelObject, chatId: String) -> Promise<Void> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            
            let chatModel = ChatModel(chatId: chatId, eventCreatorId: currentUser.uid, matchedUserId: userModel.userId, eventId: eventModel.eventId, messages: [])
            do {
                let _ = try db.collection("chats")
                    .document(chatId).setData(from:chatModel) { error in
                        if let error = error {
                            seal.reject(error)
                        }
                    }
            }catch { let error = error
                seal.reject(error)
            }
            seal.fulfill(())
        }
    }
    
    // MARK: -  delete a like from User
    
    //Aktuel nicht genutzt
    func deleteLikedUser(eventModel: EventModelObject, userModel: UserModelObject) -> Promise<Void> {
        return Promise { seal in
            
            db.collection("events")
                .document(eventModel.eventId)
                .collection("likedUser")
                .document(userModel.userId).delete() { error in
                    if let error = error {
                        seal.reject(error)
                    }
                }
            seal.fulfill(())
        }
    }
    
    //Muss noch implementiert werden
    func deleteMatchFromUserProfile(userModel: UserModel) -> Promise<Void> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            db.collection("users")
                .document(currentUser.uid)
                .collection("matches")
                .document(userModel.userId).delete() { error in
                    if let error = error {
                        seal.reject(error)
                    }
                }
            seal.fulfill(())
        }
    }
}
