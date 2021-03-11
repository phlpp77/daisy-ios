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
import MapKit
import GeoFire

class ProfileCreationModel: ObservableObject {
    
    private var firestoreManagerUserTest: FirestoreManagerUserTest
    private var firestoreFotoMangerUserTest: FirestoreFotoManagerUserTest
    private var locationManager: LocationManager = LocationManager()
    @Published var saved: Bool = false
    @Published var message: String = ""
    private var counter = 1
    
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
    
    func askLocation() {
        _ = locationManager.$location.sink { location in
            _ = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 200, longitudinalMeters: 200)
        }
    }


    
    func createUser(images: [UIImage]?, bDate: String) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        self.birthdayDate = convertStringToDate(date: bDate)
        
        let userModel = UserModel(userId: currentUser.uid, name: name, birthdayDate: birthdayDate, gender: gender, startProcessDone: startProcessDone, searchingFor : searchingFor, userPhotos: [1: stockUrlString], radiusInKilometers: 1000)
        
        firstly {
            self.firestoreManagerUserTest.saveUser(userModel: userModel)
        }.then {
            self.firestoreManagerUserTest.createLikedEventsArray()
        }.then {
            when(fulfilled: images!.compactMap(self.uploadUserPhotos)).done {
                print("FINISH")
            }
        }.catch { error in
            print("DEBUG: catch, fehler in event creation \(error)")
            print(error.localizedDescription)
        }
        
        
        
        
    }
        
//}.then {
//    when(fulfilled: self.matchDoc.compactMap(self.getAllMatchInformation)).done { result in
//        self.matches = result
//    }.done{
//        self.matches = self.matches.sorted{
//            $0.event.distance < $1.event.distance
//
//        }
    
    //        }.then { userModel in
    //            self.firestoreFotoMangerUserTest.resizeImage(originalImages: images)
    //        }.then { picture in
    //            self.firestoreFotoMangerUserTest.uploadUserPhoto(data: picture)
    //        }.then { urls in
    //            self.firestoreFotoMangerUserTest.savePhotoUrlToFirestore(url1: urls[0], url2: urls[1], url3: urls[2])
    
    func uploadUserPhotos(originalImage: UIImage) -> Promise<Void> {
        return Promise { seal in
            firstly{
                self.firestoreFotoMangerUserTest.resizeImage(originalImage: originalImage)
            }.then { picture in
                self.firestoreFotoMangerUserTest.uploadUserPhoto(data: picture, fotoPlace: self.counter)
            }.then { url in
                self.firestoreFotoMangerUserTest.savePhotoUrlToFirestore(url: url, fotoPlace: self.counter)
            }.done {
                print(self.counter)
                self.counter = self.counter + 1
                seal.fulfill(())
            }.catch { error in
                seal.reject(error)
                
            }
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
