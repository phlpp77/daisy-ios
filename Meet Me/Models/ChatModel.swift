//
//  ChatModel.swift
//  Meet Me
//
//  Created by Lukas Dech on 27.02.21.
//

import Foundation

struct ChatModel: Codable {
    var chatId: String
    var eventCreatorId: String
    var matchedUserId: String
    var eventId: String
    var messages: [MessageModel]
}

struct MessageModel: Codable {
    var userId: String
    var timeStamp: Double
    var messageText: String
}
