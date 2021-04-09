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
    @Published var developerOptionsModel = DeveloperOptionsModel(maintenance: false, reason: "")
    
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
    
    func getMaintenanceMode() -> Promise<Void> {
        return Promise { seal in

            db.collection("developerOptions").document("developerOptions").addSnapshotListener { snapshot, error in
                if let error = error {
                    seal.reject(error)
                } else {
                    if let snapshot = snapshot {
                        let developerOptionsModel = try? snapshot.data(as: DeveloperOptionsModel.self)
                        DispatchQueue.main.async {
                            if developerOptionsModel != nil {
                                self.developerOptionsModel = developerOptionsModel!
                                seal.fulfill(())
                            }else {
                                let err = Err("developer Options")
                                seal.reject(err)
                            }
                        }
                        
                        
                    }
                }
                
            }
            
            
        }
    }
    
}
