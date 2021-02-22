//
//  YouEventViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 19.02.21.
//

import Foundation
import PromiseKit

class YouEventViewModel: ObservableObject {
    
    private var firestoreManagerUserTest: FirestoreManagerUserTest
    private var firestoreManagerEventTest: FireStoreManagerEventTest
    private var currentUserModel: UserModel = stockUser
    
    
    init(){
        firestoreManagerUserTest = FirestoreManagerUserTest()
        firestoreManagerEventTest = FireStoreManagerEventTest()
    }
    

    
    
//    func getUserModel(){
//        firestoreManagerUserTest.downloadCurrentUserModel(completion: { success in
//                if success {
//                    DispatchQueue.main.async {
//                        self.currentUserModel = self.firestoreManagerUser.getCurrentUserModel()
//                    }
//                } else {
//                    print("Download User Failed")
//                }
//            }
//            )
//        }
//
    func addLikeToEvent(eventId: String){
        firstly {
            self.firestoreManagerUserTest.downloadCurrentUserModel()
        }.then { userModel in
            self.firestoreManagerEventTest.addLikeToEvent(eventId: eventId, userModel: userModel)
        }.catch { error in
            print("DEBUG: error in getUserModelChain \(error)")
            print("DEBUG \(error.localizedDescription)")
        }
    }
}
    
//    func addCurrentUserToMatchedEvent(eventId: String, completion: @escaping (Error?) -> Void) {
//        getUserModel()
//        if currentUserModel.userId != stockUser.userId {
//           // print("right User Uploaded ")
//        } else {
//            //print("testUserUploaded")
//        }
//        firestoreManagerEventTest.addLikeToEvent(eventId: eventId, userModel: currentUserModel) { result in
//            switch result {
//            case.success(_):
//                completion(nil)
//            case .failure(let error):
//                completion(error)
//            }
//        }
//
//    }
//}



