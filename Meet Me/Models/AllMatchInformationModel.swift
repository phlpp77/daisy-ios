//
//  AllMatchInformationModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 27.02.21.
//

import Foundation

struct AllMatchInformationModel: Codable {
    var chatId: String
    
//All User Informations
    var user: UserModel
    var event: EventModel
}

