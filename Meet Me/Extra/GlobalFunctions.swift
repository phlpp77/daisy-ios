//
//  GlobalFunctions.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 14.02.21.
//

import Foundation

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
// MARK - Stockdata

// MARK: stock user to use as default
let stockUser: UserModel = UserModel(userId: "007", name: "Philipp", birthdayDate: createSampleDate(), gender: "Male", searchingFor: "Female", userPhotos: [1: stockUrlString])
let stockUser2: UserModel = UserModel(userId: "008", name: "Lisa", birthdayDate: createSampleDate(), gender: "Female", searchingFor: "Male", userPhotos: [1: stockUrlString])

let stockUserObject: UserModelObject = UserModelObject(user: stockUser)

// TODO: Need to be changed to a stock photo
let stockURL: URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/meetme-1c961.appspot.com/o/UserImages%2FE0E6E182-1625-4519-9315-531980665268.png?alt=media&token=a77b552b-d687-4367-bee2-76b625fe8e48")!

let stockUrlString: String = "https://firebasestorage.googleapis.com/v0/b/meetme-1c961.appspot.com/o/UserImages%2FE0E6E182-1625-4519-9315-531980665268.png?alt=media&token=a77b552b-d687-4367-bee2-76b625fe8e48"

// MARK: stock event for marketplace and eventObject (length: half an hour - 30*60 seconds)
let stockEvent: EventModel = EventModel(eventId: "008", userId: "007", name: "Nice Event", category: "Café", date: Date(), startTime: Date(), endTime: Date() + 30 * 60, pictureURL: "", profilePicture: "")
let stockEvent2: EventModel = EventModel(eventId: "009", userId: "008", name: "Nice Event", category: "Walk", date: Date(), startTime: Date(), endTime: Date() + 30 * 60, pictureURL: "", profilePicture: "")

let stockEventObject: EventModelObject = EventModelObject(eventModel: stockEvent, position: .constant(.zero))

