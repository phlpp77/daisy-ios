//
//FirestoreFotoManager.swift
//Meet Me
//
//Created by Lukas Dech on 11.02.21.
//
//
//Funktions Beschreibung
//
//- savePhoto()
// saved ein Event Model zur collection User
// wird aufgerufen in --> EventCreationViewModel

//- UploadUserPhoto()
// ladet alle Events des aktuellen Nutzers herunter und speichert alle im Array meEvents vom Typ EventModelObject
// wird aufgerufen in --> YouEventViewModel

//- savePhotoUrlToFirestore()
// return das Array meEvents welches von getMeEvent() objekte bekommt
// wird aufgerufen in --> YouEventViewModel

//- getAllPhotosFromUser()
// return das Array meEvents welches von getMeEvent() objekte bekommt
// wird aufgerufen in --> YouEventViewModel


import Foundation
import Firebase
import FirebaseFirestoreSwift
import URLImage


class FirestoreFotoManager: ObservableObject {
    
    let storage = Storage.storage()
    private var db: Firestore
    @Published var photoModel: [PhotoModelObject] = []
    var stockPhotoModel: PhotoModel = PhotoModel()
    var url: URL?

     
    init() {
          db = Firestore.firestore()
    }
    


    // function is called inside the main code
    func savePhoto(originalImage: UIImage?,collection: String, childFolder: String, completion: @escaping (Bool) -> Void) {
        var completionFlag = false
        
        if let originalImage = originalImage {
            if let resizedImage = originalImage.resized(width: 360) {
                if let data = resizedImage.pngData() {
                    uploadUserPhoto(data:data, childFolder: childFolder) { (url) in
                        if let url = url {
                            self.savePhotoUrlToFirestore(url: url, collection: collection) { error in
                                if let error = error {
                                    print(error.localizedDescription)
                                    completion(completionFlag)
                                } else {
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
    func uploadUserPhoto(data: Data, childFolder: String, completion: @escaping (URL?) -> Void) {
        
        let imageName = UUID().uuidString
        let storageRef = storage.reference()
        let photoRef = storageRef.child("\(childFolder)/\(imageName).png")
        
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
    func savePhotoUrlToFirestore(url: URL, collection: String, completion: (Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        do {
            let _ = try db.collection(collection)
                .addDocument(from: PhotoModel(url: url.absoluteString, userId: currentUser.uid))
                completion(nil)
        } catch let error {
            completion(error)
        }
        
        
    }
    
    
    
    
    func getAllPhotosFromUser(collection:String, completionHandler: @escaping (Bool) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        var flag = false
        db.collection(collection)
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
                            completionHandler(flag)
                            
                        }
                    }
                }
            }
        
        
        
    }
 


}
