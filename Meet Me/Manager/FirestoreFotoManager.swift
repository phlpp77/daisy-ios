////
////  FirestoreFotoManager.swift
////  Meet Me
////
////  Created by Lukas Dech on 11.02.21.
////
//
import Foundation
import Firebase
import FirebaseFirestoreSwift
import URLImage


class FirestoreFotoManager: ObservableObject {
    
    let storage = Storage.storage()
    private var db: Firestore
     
    init() {
          db = Firestore.firestore()
    }
    
    @Published var photoModel: [PhotoModelObject] = []
    
    var stockPhotoModel: PhotoModel = PhotoModel()
    var url: URL?
    //var test: PhotoModelObject = PhotoModelObject(photoModel: testphotoModel)

    
    func savePhoto(originalImage: UIImage?) {
        
        if let originalImage = originalImage{
            if let resizedImage = originalImage.resized(width:1024) {
                if let data = resizedImage.pngData() {
                    uploadUserPhoto(data:data) { [self] (url) in
                        if let url = url {
                            savePhotoUrlToFirestore(url: url) { error in
                                
                                
                                
                            }
                        }
                    }
                    
                }
            }
            
        }
    }
    
    
    //Wird nicht direkt aufgerufen -> wird in savePhoto aufgerufen
    func uploadUserPhoto(data: Data, completion: @escaping (URL?) -> Void) {
        
        let imageName = UUID().uuidString
        let storageRef = storage.reference()
        let photoRef = storageRef.child("UserImages/\(imageName).png")
        
        photoRef.putData(data, metadata: nil) { metadata, error in
            photoRef.downloadURL { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    completion(url)
                }
            }
        }
        
    }
    
    //Wird nicht direkt aufgerufen -> wird in savePhoto aufgerufen
    func savePhotoUrlToFirestore(url: URL, completion: (Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        do {
            let _ = try db.collection("UserPhotos")
                .addDocument(from: PhotoModel(url: url.absoluteString, userId: currentUser.uid))
                completion(nil)
        } catch let error {
            completion(error)
        }
        
        
    }
    
    func getAllPhotosFromUser() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        db.collection("UserPhotos")
            .whereField("userId", isEqualTo: currentUser.uid)
            .getDocuments { (snapshot,error) in
                if let error = error {
                    print(error.localizedDescription)
                    print("Konnte FOTTO NICHT runterladen")
                } else {
                    
                    if let snapshot = snapshot {
                        let photoModel: [PhotoModelObject] = snapshot.documents.compactMap { doc in
                            var photoModel = try? doc.data(as: PhotoModel.self)
                            photoModel?.id = doc.documentID
                            if let photoModel = photoModel {
                                print(photoModel)
                                return PhotoModelObject(photoModel: photoModel)
                            }
                            print("getAllUser return nil")
                            return nil
                            
                        }
                        DispatchQueue.main.async {
                            self.photoModel = photoModel
                            
                        }
                    }
                }
            }
    }
    
    func getProfilePhoto() -> URL {
        getAllPhotosFromUser()
        if photoModel.count > 0{
            url = URL(string: photoModel[0].url)!
            return url!
        } else {
            let photoModelObject = PhotoModelObject(photoModel: stockPhotoModel)
            url = URL(string: photoModelObject.url)!
            return url!
            
        }
    }
    

}
