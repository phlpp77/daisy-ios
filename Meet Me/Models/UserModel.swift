//
//  UserModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 25.01.21.
//

import Foundation
import SwiftUI

struct UserModel: Codable {
    
    var userId: String = ""
    var name: String = ""
    var birthdayDate: Date = Date()
    var gender: String = ""
    var startProcessDone: Bool = true
    var searchingFor: String = ""
    var userPhotos: [Int: String]
    var radiusInKilometers: Double

    
}

struct UserModelObject {
    
    let user: UserModel

    
    var name: String {
        user.name
    }
    
    var birthdayDate: Date {
        user.birthdayDate
    }
    
    var gender: String {
        user.gender
    }
    
    var startProcessDone: Bool {
        user.startProcessDone
    }
    
    var searchingFor: String {
        user.searchingFor
    }
    
    var userId: String {
        user.userId
    }
    
    var userPhotos: [Int: String] {
        user.userPhotos
    }

    
    
}


