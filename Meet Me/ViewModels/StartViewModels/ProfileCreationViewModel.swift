//
//  ProfileCreationModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 29.01.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import PromiseKit

class ProfileCreationModel: ObservableObject {
    
    private var firestoreManagerUserTest: FirestoreManagerUserTest
    private var firestoreFotoMangerUserTest: FirestoreFotoManagerUserTest
    @Published var saved: Bool = false
    @Published var message: String = ""
    
    var userId: String = ""
    var name: String = "Name"
    var birthdayDate: Date = Date()
    var gender: String = "Gender"
    var searchingFor: String = ""
    var startProcessDone: Bool = true
    
    let storage = Storage.storage()
    
    
    init() {
        firestoreManagerUserTest = FirestoreManagerUserTest()
        firestoreFotoMangerUserTest = FirestoreFotoManagerUserTest()
    }
    

    
    func createUser(originalImage: UIImage, bDate: String) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        self.birthdayDate = convertStringToDate(date: bDate)
        
        let userModel = UserModel(userId: currentUser.uid, name: name, birthdayDate: birthdayDate, gender: gender, startProcessDone: startProcessDone, searchingFor : searchingFor, userPhotos: [1: stockUrlString])
        
        firstly {
            self.firestoreManagerUserTest.saveUser(userModel: userModel)
        }.then { userModel in
            self.firestoreFotoMangerUserTest.resizeImage(originalImage: originalImage)
        }.then { picture in
            self.firestoreFotoMangerUserTest.uploadUserPhoto(data: picture)
        }.then { url in
            self.firestoreFotoMangerUserTest.savePhotoUrlToFirestore(url: url, fotoPlace: 1)
        }.then {
            self.firestoreManagerUserTest.createLikedEventsArray()
        }.catch { error in
            print("DEBUG: catch, fehler in event creation \(error)")
            print(error.localizedDescription)
        }
        
        
    }
    
    
    
    func convertStringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_DE")
        dateFormatter.dateFormat = "dd/MM/y"
        
        let date = dateFormatter.date(from: date)!
        return date
    }

}
