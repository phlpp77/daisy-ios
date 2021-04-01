//
//  DeveloperManager.swift
//  Meet Me
//
//  Created by Lukas Dech on 01.04.21.
//

import Foundation
import Firebase
import PromiseKit

class DeveloperManager: ObservableObject  {
    
    private var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }

    func setMaintenanceMode(status: Bool) -> Promise<Void> {
        return Promise { seal in
            let _ = db.collection("developerOptions").document("developerOptions").setData(["maintenance" : status], merge: true) { error in
                if let error = error {
                    seal.reject(error)
                }else {
                    seal.fulfill(())
                }
            }
        }
    }
}
