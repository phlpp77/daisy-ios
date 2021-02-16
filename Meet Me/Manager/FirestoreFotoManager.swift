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
    @Published var photoModel: [PhotoModelObject] = []
    //typealias CompletionHandler = (_ success: Bool) -> Void
     
    init() {
          db = Firestore.firestore()
    }
    
    
    
    var stockPhotoModel: PhotoModel = PhotoModel()
    var url: URL?
    //var test: PhotoModelObject = PhotoModelObject(photoModel: testphotoModel)

    // function is called inside the main code
    func savePhoto(originalImage: UIImage?, completion: @escaping (Bool) -> Void) {
        var completionFlag = false
        
        print("func start savePhoto")
        if let originalImage = originalImage {
            if let resizedImage = originalImage.resized(width: 360) {
                print("image resizing")
                if let data = resizedImage.pngData() {
                    print("image resized")
                    uploadUserPhoto(data:data) { (url) in
                        if let url = url {
                            print("write url to database")
                            self.savePhotoUrlToFirestore(url: url) { error in
                                if let error = error {
                                    print(error.localizedDescription)
                                    completion(completionFlag)
                                } else {
                                    //getAllPhotosFromUser(completionHandler: (Bool) -> Void)
                                    completionFlag = true
                                    completion(completionFlag)
                                }
                                
                                
                            }
                        }
                    }
                    
                }
            }
            
        }
    }
    
    
    //Wird nicht direkt aufgerufen -> wird in savePhoto aufgerufen
    func uploadUserPhoto(data: Data, completion: @escaping (URL?) -> Void) {
        
        print("func start uploaded user photo")
        let imageName = UUID().uuidString
        let storageRef = storage.reference()
        let photoRef = storageRef.child("UserImages/\(imageName).png")
        
        print("now start to put data ")
        photoRef.putData(data, metadata: nil) { metadata, error in
            
            if let err = error {
                print(err.localizedDescription)
            }
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
    
    func getAllPhotosFromUser(completionHandler: @escaping (Bool) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        var flag = false
        db.collection("UserPhotos")
            .whereField("userId", isEqualTo: currentUser.uid)
            .getDocuments { (snapshot,error) in
                if let error = error {
                    print(error.localizedDescription)
                    flag = false
                } else {
                    if let snapshot = snapshot {
                        let photoModel: [PhotoModelObject] = snapshot.documents.compactMap { doc in
                            var photoModel = try? doc.data(as: PhotoModel.self)
                            photoModel?.id = doc.documentID
                            if let photoModel = photoModel {
                                print("User Bilder")
                                print(photoModel)
                                flag = true
                                return PhotoModelObject(photoModel: photoModel)
                            }
                            flag = false
                            return nil
                            
                        }
                        DispatchQueue.main.async {
                            self.photoModel = photoModel
                            print(self.photoModel)
                            print("now completion ")
                            completionHandler(flag)
                            
                        }
                    }
                }
            }
        
        
        
    }
 
    
//    //ACHTUNG nochmal bearbeiten
//    func getProfilePhoto() -> URL {
//        getAllPhotosFromUser()
//        if photoModel.count > 0{
//            url = URL(string: photoModel[0].url)!
//            return url!
//        } else {
//            let photoModelObject = PhotoModelObject(photoModel: stockPhotoModel)
//            url = URL(string: photoModelObject.url)!
//            return url!
//
//        }
//    }
    

}
