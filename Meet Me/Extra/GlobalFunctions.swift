//
//  GlobalFunctions.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 14.02.21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

// MARK: Get information from screen etc
// get the size of the screen (defined here that it can be used in every View)
let screen = UIScreen.main.bounds

// MARK: Function to get the age from a date object

func dateToAge(date: Date) -> Int {
    let lifeTime = date.timeIntervalSinceNow
    let years = -lifeTime / 60 / 60 / 24 / 365
    return Int(years)
}

// MARK: create a sample date
func createSampleDate() -> Date {
    
    var dateComponents = DateComponents()
    dateComponents.year = 1998
    dateComponents.month = 9
    dateComponents.day = 6
    
    // since the components above (like year 1980) are for Gregorian
    let userCalendar = Calendar(identifier: .gregorian)
    
    let someDateTime = userCalendar.date(from: dateComponents)!
    return someDateTime
}
var createdId = UUID().uuidString

// MARK: - Colors

// MARK: Gradient which is the secondary color (blueish) and marks cancel and abort actions
let secondaryGradient = LinearGradient(
    gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.0313725508749485, green: 0.45490196347236633, blue: 0.5490196347236633, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.0313725471496582, green: 0.4549018144607544, blue: 0.5490196347236633, alpha: 0.6299999952316284)), location: 1)]),
    startPoint: UnitPoint(x: 0.9999999999999999, y: 7.105427357601002e-15),
    endPoint: UnitPoint(x: -2.220446049250313e-16, y: -1.7763568394002505e-15)
)


// MARK - Stockdata

// MARK: stock user to use as default
let stockUser: UserModel = UserModel(userId: "007", name: "Stocky One", birthdayDate: createSampleDate(), gender: "Male", searchingFor: "Female", userPhotos: [1: stockUrlString], userPhotosId: [1: ""], radiusInKilometer: 1000)
let stockUser2: UserModel = UserModel(userId: "008", name: "Stockise Two", birthdayDate: createSampleDate(), gender: "Female", searchingFor: "Male", userPhotos: [1: stockUrlString], userPhotosId: [1: ""], radiusInKilometer: 1000)



// TODO: Need to be changed to a stock photo
let stockURL: URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/meetme-1c961.appspot.com/o/StockImages%2FstockPic.jpg?alt=media&token=59dfa4eb-81b0-4845-80f6-33b35f305414")!

let stockUrlString: String = "https://firebasestorage.googleapis.com/v0/b/meetme-1c961.appspot.com/o/StockImages%2FstockPic.jpg?alt=media&token=59dfa4eb-81b0-4845-80f6-33b35f305414"

// MARK: stock event for marketplace and eventObject (length: half an hour - 30*60 seconds)
let stockEvent: EventModel = EventModel(eventId: "008", userId: "007", category: "Café", date: Date(), startTime: Date(), endTime: Date() + 30 * 60, pictureURL: "", profilePicture: "",likedUser: false,eventMatched: false,latitude: 0.0, longitude: 0.0, hash: "", distance: 0, searchingFor: "Male", genderFromCreator: "Female", birthdayDate: Date())
let stockEvent2: EventModel = EventModel(eventId: "009", userId: "008", category: "Walk", date: Date(), startTime: Date(), endTime: Date() + 30 * 60, pictureURL: "", profilePicture: "",likedUser: false,eventMatched: false,latitude: 0.0, longitude: 0.0, hash: "", distance: 0,searchingFor: "Male", genderFromCreator: "Female", birthdayDate: Date())

//let stockEventObject: EventModel = EventModelObject(eventModel: stockEvent, position: .constant(.zero))

// MARK: stock chat for chat area
let stockChat: ChatModel = ChatModel(chatId: "egal", eventCreatorId: "creatoRR", matchedUserId: "receiveRR", eventId: "egal2", messages: [MessageModel(userId: "egal3", timeStamp: Timestamp(date: Date()), messageText: "Hey you got a match, speek with your meeter about your event seetings")])

