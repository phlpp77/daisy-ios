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

// MARK - Stockdata

// MARK: stock user to use as default
let testUser: UserModel = UserModel(userId: "007", name: "Philipp", birthdayDate: createSampleDate(), gender: "Male", searchingFor: "Female")

// TODO: Need to be changed to a stock photo
let stockURL: URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/meetme-1c961.appspot.com/o/UserImages%2F13F2F426-CA65-4E9E-A433-A7B8E866B55B.png?alt=media&token=acbe4056-8993-479d-99f5-bcac9185548b")!

// MARK: stock event for marketplace and eventObject (length: half an hour - 30*60 seconds)
let stockEvent: EventModel = EventModel(eventId: "008", userId: "007", name: "Nice Event", category: "Café", date: Date(), startTime: Date(), endTime: Date() + 30 * 60, pictureURL: stockURL)
let stockEventObject: EventModelObject = EventModelObject(eventModel: stockEvent, position: .constant(.zero))
