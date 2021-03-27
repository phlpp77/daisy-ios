//
//  DeveloperViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 27.03.21.
//

import Foundation
import PromiseKit
import Firebase



class DeveloperViewModel: ObservableObject {
    private var firestoreManagerMatches: FirestoreManagerMatches = FirestoreManagerMatches()
    private var firestoreManagerUserTest: FirestoreManagerUserTest = FirestoreManagerUserTest()
    private var firestoreFotoManagerUserTest: FirestoreFotoManagerUserTest = FirestoreFotoManagerUserTest()
    private var firestoreManagerEventTest: FirestoreManagerEventTest = FirestoreManagerEventTest()
    private var firestoreFotoManagerEventTest: FirestoreFotoManagerEventTest = FirestoreFotoManagerEventTest()
    private var firestoreManagerChat: FirestoreManagerChat = FirestoreManagerChat()
    private var db: Firestore
    
    private var Ids: [String] = []
    
    
    init() {
        db = Firestore.firestore()
        
    }
    
    func setShuffelCouterToZeroAllUsers() {
        firstly {
            getAllUserIDs()
        }.then { userIds in
            when(fulfilled: self.Ids.compactMap(self.setRefreshcounterTozero))
        }.done {
            print("done")
        }.catch { error in
            print(error)
        }
    }
    
    func getAllUserIDs() ->Promise<Void> {
        return Promise { seal in
            let _ = db.collection("users").getDocuments {(snapshot, error) in
                if let error = error {
                    seal.reject(error)
                } else {
                    if let snapshot = snapshot {
                        print(snapshot.description)
                        let userIDs: [String] = snapshot.documents.compactMap { doc in
                            let user = try? doc.data(as: UserModel.self)
                            if let user = user {
                                return user.userId
                            }
                            return nil
                        }
                        DispatchQueue.main.async {
                            print(userIDs)
                            self.Ids = userIDs
                            seal.fulfill(())
                        }
                    }
                }
            }
        }
    }
    
    func setRefreshcounterTozero(userId: String) -> Promise<Void> {
        return Promise { seal in
            let _ = db.collection("users")
                .document(userId).updateData(["refreshCounter": 0]) { error in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        seal.fulfill(())
                    }
                }
        }
    }
    
    
    func deleteAllOldEvents() {
        
    }
    
    func getAllChats() {
        
    }
    
}
