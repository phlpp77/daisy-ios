//
//  Enums.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 05.03.21.
//

import Foundation

// MARK: Marks the status of an event
// used in: MeMatchStartView
enum EventStatus {
    // user has no likes on his event yet (no swipe possible)
    case notLiked
    // user has a minimum of one like on his event (swiping possible)
    case liked
    // user has matched someone (further swiping not possible)
    case matched
}

// MARK: Each tabView has its own identifier
// used in: TabBarView
enum Tab {
    // tabView for the profile page/tab
    case profile
    // tabView for the marketplace page/tab
    case marketplace
    // tabView for the chat page/tab
    case chat
}

// MARK: Each StartView has its own identifier
// used in: MainStartView
enum StartPosition {
    // StartView for the first picture of the app
    case splash
    // StartView for the onboarding slides
    case onboarding
    // StartView for the login and register view
    case registerLogin
    // StartView for the profileCreation of the user
    case profileCreation
}

// MARK: The Distance of each location is shown in words
// used in: YouEventView
enum Distance: String {
    // here distance is 10 km
    case here
    // near distance is 30 km
    case near
    // far distance is over 30 km until set range
    case far
}
