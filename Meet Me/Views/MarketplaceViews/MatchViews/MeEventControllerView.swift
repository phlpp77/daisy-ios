//
//  MeEventControllerView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 21.02.21.
//

import SwiftUI
import PromiseKit

struct MeEventControllerView: View {
    
    @StateObject private var meEventControllerVM: MeEventControllerViewModel = MeEventControllerViewModel()
    
    @Binding var showMeEventDetailedView: Bool
    @Binding var tappedEvent: EventModel
    
    @State var userChosen: Bool = false
    @State var showMeMatchCardView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            // MARK: Stack with Users to swipe and like
            ZStack {
                ForEach(meEventControllerVM.likedUsers.indices, id: \.self ) { userNumber in
//                    MeMatchCardView(userChosen: $userChosen, users: $meEventControllerVM.likedUsers, event: $tappedEvent, user: meEventControllerVM.likedUsers[userNumber], userNumber: userNumber, showMeMatchMainView: $showMeEventDetailedView)
                    MeMatchNCardView(showMeMatchNCardView: $showMeMatchCardView, likedUsers: $meEventControllerVM.likedUsers, userAccepted: $userChosen, event: tappedEvent, userIndex: userNumber)
                        .opacity(showMeMatchCardView ? 1 : 0)
                }
            }
            
            // MARK: DetailedView to start matching or editing/deleting the event
            MeEventDetailedView(showMeEventDetailedView: $showMeEventDetailedView, showMeMatchCardView: $showMeMatchCardView, event: $tappedEvent, likedUsers: $meEventControllerVM.likedUsers)
                .opacity(showMeMatchCardView ? 0 : 1)
            
        }
        .animation(.easeInOut)
        
        // MARK: OnAppear to get the likedUsers from the Database
        .onAppear {
            meEventControllerVM.getLikedUsers(eventId: tappedEvent.eventId)
            
        }
    }
}

struct MeMatchView_Previews: PreviewProvider {
    static var previews: some View {
        MeEventControllerView(showMeEventDetailedView: .constant(true), tappedEvent: .constant(stockEvent))
    }
}
