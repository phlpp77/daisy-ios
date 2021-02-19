//
//  ProfileCreationModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 29.01.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class EventCreationViewModel: ObservableObject {
    
    private var firestoreFotoManagerEvent: FirestoreFotoManagerEvent = FirestoreFotoManagerEvent()
    private var fireStoreManagerEvent: FireStoreManagerEvent
    @Published var saved: Bool = false
    @Published var message: String = ""
    
    
    var userId: String = "111"
    var name: String = "Nice Event"
    var eventId: String = "222"
    var category: String = "Café"
    var date: Date = Date()
    var startTime: Date = Date ()
    var endTime: Date = Date() + 30 * 60
    var pictureURL: String = ""
    let storage = Storage.storage()
    

    init() {
        fireStoreManagerEvent = FireStoreManagerEvent()
    }
    
    func saveEventSettings(uiImage: UIImage) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        
        //Start to Save Event
        let eventModel = EventModel(eventId: fireStoreManagerEvent.getID(), userId: currentUser.uid, name: name, category: category, date: date, startTime: startTime, endTime: endTime, pictureURL: "https://firebasestorage.googleapis.com/v0/b/meetme-1c961.appspot.com/o/UserImages%2FE0E6E182-1625-4519-9315-531980665268.png?alt=media&token=a77b552b-d687-4367-bee2-76b625fe8e48")
        
        fireStoreManagerEvent.saveEvent(eventModel: eventModel){ result in
            switch result {
            case .success(let eventModel):
                DispatchQueue.main.async {
                    self.firestoreFotoManagerEvent.savePhoto(originalImage: uiImage, eventModel: eventModel!, completion: { success in
                        if success {
                            //print("PHOTO: in eventModel \(self.pictureURL)")
                            self.saved = eventModel == nil ? false: true
                        } else {
                        print("fehler EventCreationViewModel")
                    }
                    })
                    //print("PHOTO: in eventModel \(self.pictureURL)")
                    self.saved = eventModel == nil ? false: true
                    
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self .message = ErrorMessages.eventSaveFailed
                }
                
            
            }
        }
    }
}
//firestoreFotoMangerUser.savePhoto(originalImage: uiImage, completion: { success in
//    if success {
//    } else {
//        print("error by save User Seetings to Firebase")
//    }
//})
    
//    //get foto url for Event
//    guard let currentUser = Auth.auth().currentUser else {
//        return
//    }
//    firestoreFotoManagerEvent.getAllPhotosFromEvent(completionHandler: { success in
//        if success {
//            // yeah picture
//
//
//            let url = URL(string: self.firestoreFotoManagerEvent.photoModel[0].url)!
//            //print("PHOTO: right url load by savin event URL: \(url)")
//
//
//            self.pictureURL = url
//            //print("PHOTO: pictureURL at the moment: \(self.pictureURL)")
//
//        } else {
//            //print("stockUrl load by saving event")
//            self.pictureURL = stockURL
//        }
//
//    })
//
//
//}
//
//    func getEventPictureURL() -> URL{
//        firestoreFotoManager.getAllPhotosFromUser(collection:"EventPhotos", completionHandler: { success in
//            if success {
//                // yeah picture
//
//
//                let url = URL(string: self.firestoreFotoManager.photoModel[0].url)!
//                return url
//
//            } else {
//                // ohh, no picture
//                return stockURL
//            }
//
//        })
//    }
//}






