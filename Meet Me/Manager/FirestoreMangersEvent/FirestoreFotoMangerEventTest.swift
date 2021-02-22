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

    // function is called inside the main code
//    //in dem Paramter collection wird ein Document mit Url und User Id erstellt
//    //paramter childfolder lädt das dokument in den Storage
//    func savePhoto(originalImage: UIImage?, eventModel: EventModel, completion: @escaping (Bool) -> Void) {
//        var completionFlag = false
//
//        if let originalImage = originalImage {
//            if let resizedImage = originalImage.resized(width: 360) {
//                if let data = resizedImage.pngData() {
//                    uploadEventPhoto(data:data) { (url) in
//                        if let url = url {
//                            self.saveEventPhotoUrlToFirestore(url: url, eventModel: eventModel) { error in
//                                if let error = error {
//                                    print(error.localizedDescription)
//                                    completion(completionFlag)
//                                } else {
//                                    completionFlag = true
//                                    completion(completionFlag)
//                                }
//
//
//                            }
//                        }
//                    }
//
//                }
//            }
//
//        }
//    }
    
    

    
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
            let photoRef = storageRef.child("EventImagesTest/\(imageName).png")
            
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
//        guard let currentUser = Auth.auth().currentUser else {
//            return

//        }
        
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
    
    func getAllPhotosFromEvent() -> Promise<[PhotoModelObject]> {
        return Promise { seal in
            
        
        
        guard let currentUser = Auth.auth().currentUser else {
            let error: Error = "No current User" as! Error
            seal.reject(error)
            return
        }
        db.collection("users")
            .whereField("userId", isEqualTo: currentUser.uid)
            .getDocuments { (snapshot,error) in
                if let error = error {
                    print(error.localizedDescription)
                    seal.reject(error)
                } else {
                    if let snapshot = snapshot {
                        let photoModel: [PhotoModelObject] = snapshot.documents.compactMap { doc in
                            var photoModel = try? doc.data(as: PhotoModel.self)
                            photoModel?.id = doc.documentID
                            if let photoModel = photoModel {
                                return PhotoModelObject(photoModel: photoModel)
                            }
                            return nil
                            
                        }
                        DispatchQueue.main.async {
                            seal.fulfill(photoModel)
                            
                        }
                    }
                }
            }
        
        
        
    }
    }
}
