//
//  YouEventViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 19.02.21.
//

import Foundation

class YouEventViewModel: ObservableObject {
    
    private var firestoreManagerUser: FirestoreManagerUser
    private var firestoreManagerEvent: FireStoreManagerEvent
    private var currentUserModel: UserModel = testUser
    
    
    init(){
        firestoreManagerUser = FirestoreManagerUser()
        firestoreManagerEvent = FireStoreManagerEvent()
    }
    
    
    func getUserModel(){
        firestoreManagerUser.downloadCurrentUserModel(completion: { success in
                if success {
                    DispatchQueue.main.async {
                        self.currentUserModel = self.firestoreManagerUser.getCurrentUserModel()
                    }
                } else {
                    print("Download User Failed")
                }
            }
            )
        }
    
    func addCurrentUserToMatchedEvent(eventId: String, completion: @escaping (Error?) -> Void) {
        getUserModel()
        if currentUserModel.userId != testUser.userId {
           // print("right User Uploaded ")
        } else {
            //print("testUserUploaded")
        }
        firestoreManagerEvent.addLikeToEvent(eventId: eventId, userModel: currentUserModel) { result in
            switch result {
            case.success(_):
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
        
    }
}



