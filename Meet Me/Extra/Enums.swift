//
//  Enums.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 05.03.21.
//

import Foundation

// MARK: Marks the status of an event
enum EventStatus {
    // user has no likes on his event yet (no swipe possible)
    case notLiked
    // user has a minimum of one like on his event (swiping possible)
    case liked
    // user has matched someone (further swiping not possible)
    case matched
}
