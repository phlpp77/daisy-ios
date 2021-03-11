//
//  LogoutViewModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 05.03.21.
//

import Foundation
import PromiseKit
import FirebaseAuth



class LogoutViewModel: ObservableObject {
    @Published  var loggedIn = true
    
    func authSignOut() -> Promise<Void> {
        return Promise { seal in
            do {
                try Auth.auth().signOut()
                //startProcessDone = false
            } catch { let error = error
                seal.reject(error)
            }
            seal.fulfill(())
            
        }
    
    }
}
    

