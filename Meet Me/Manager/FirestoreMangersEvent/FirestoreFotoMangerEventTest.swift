//
//  FirestoreFotoMangerEvent.swift
//  Meet Me
//
//  Created by Lukas Dech on 19.02.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import URLImage
import PromiseKit


class FirestoreFotoManagerEventTest: ObservableObject {
    
    let storage = Storage.storage()
    private var db: Firestore
//    @Published var photoModel: [PhotoModelObject] = []
//    var stockPhotoModel: PhotoModel = PhotoModel()
//    var url: URL?

     
    init() {
          db = Firestore.firestore()
    }
    

    // MARK: - Functions to save User Photos to Storage and the URL to Firestore
    
    func resizeImage(originalImage: UIImage?) -> Promise<Data> {
        return Promise { seal in
            if let originalImage = originalImage {
                if let resizedImage = originalImage.resized(width: 360) {
                    if let data = resizedImage.pngData() {
                        seal.fulfill(data)
                    }
                }
            }
        }
    }
    
    //Wird nicht direkt aufgerufen -> wird in savePhoto aufgerufen
    func uploadEventPhoto(data: Data) -> Promise<URL> {
        return Promise { seal in
            
            let imageName = UUID().uuidString
            let storageRef = storage.reference()
            let photoRef = storageRef.child("EventImages/\(imageName).png")
            
            photoRef.putData(data, metadata: nil) { metadata, error in
                
                if let err = error {
                    print(err.localizedDescription)
                }
                photoRef.downloadURL { (url, error) in
                    
                    if let error = error {
                        seal.reject(error)
                    } else {
                        seal.fulfill(url!)
                    }
                }
            }
        }
        
    }
    
    
    //Wird nicht direkt aufgerufen -> wird in savePhoto aufgerufen
    func saveEventPhotoUrlToFirestore(url: URL,eventId: String) -> Promise<Void> {
 
        return Promise { seal in
            do {
                let _ = db.collection("events")
                    .document(eventId)
                    .updateData(["pictureURL" : url.absoluteString])
                //.updateData(["name": "right"])
                seal.fulfill(())
            }
        }
    }
}
    
    
