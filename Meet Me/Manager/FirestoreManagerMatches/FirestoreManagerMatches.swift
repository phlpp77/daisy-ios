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
            let matchModel = MatchModel(chatId: chatId, eventId: eventModel.eventId, matchedUserId: userModel.userId)
            do {
                let _ = try db.collection("users")
                    .document(currentUser.uid)
                    .collection("matches").document(chatId).setData(from: matchModel) { error in
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

            let matchModel = MatchModel(chatId: chatId, eventId: eventModel.eventId, matchedUserId: currentUser.uid)
            do {
                let _ = try db.collection("users")
                    .document(userModel.userId)
                    .collection("matches").document(chatId).setData(from: matchModel) { error in
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
    
    // MARK: -  delete a Match
    
    func deleteMatchFromCurrentUser(chatId: String) ->Promise<Void> {
        return Promise { seal in
            guard let currentUser = Auth.auth().currentUser else {
                return
            }
            let _ = db.collection("users")
                .document(currentUser.uid).collection("matches").document(chatId).delete { error in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        seal.fulfill(())
                    }
                }
        }
    }
    
    
    func deleteMatchFromMatchedUser(chatId: String, matchedUserId: String) ->Promise<Void> {
        return Promise { seal in
            let _ = db.collection("users")
                .document(matchedUserId).collection("matches").document(chatId).delete { error in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        seal.fulfill(())
                    }
                }
        }
    }
    
    func deleteChat(chatId:String) ->Promise<Void> {
        return Promise { seal in
            let _ = db.collection("chats").document(chatId).delete { error in
                if let error = error {
                    seal.reject(error)
                } else {
                    seal.fulfill(())
                }
            }
        }
    }
    
    func deleteEvent(eventId: String) ->Promise<Void> {
        return Promise { seal in
            let _ = db.collection("events").document(eventId).delete { error in
                if let error = error {
                    seal.reject(error)
                } else {
                    seal.fulfill(())
                }
            }
        }
    }
    
    func deleteAllLikedUserFromEvent(eventId: String) ->Promise<Void> {
        return Promise { seal in
            let _ = db.collection("events").document(eventId).collection("likedUser").document("likedUser").delete { error in
                if let error = error {
                    seal.reject(error)
                } else {
                    seal.fulfill(())
                }
            }
        }
    }
    
    func setLikedUserAndMatchedUserToFalse(eventId: String) ->Promise<Void> {
        return Promise { seal in
            let _ = db.collection("events").document(eventId).updateData(["likedUser": false, "eventMatched": false]) { error in
                if let error = error {
                    seal.reject(error)
                }else {
                    seal.fulfill(())
                }
            }
        }
    }

    
    
    
    
    
    
    
    //Aktuel nicht genutzt
    func deleteLikedUser(eventModel: EventModelObject, userModel: UserModelObject) -> Promise<Void> {
        return Promise { seal in
            print("delete liked User in Firestore aufgerufen")
            print("evetnId: \(eventModel.eventId)")
            print("userId: \(userModel.userId)")
            db.collection("events")
                .document(eventModel.eventId)
                .collection("likedUser")
                .document("likedUser").updateData(["likedUser" : FieldValue.arrayRemove([userModel.userId])]) { error in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        seal.fulfill(())
                    }
                }

        }
    }
}
    
