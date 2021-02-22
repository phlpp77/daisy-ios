//
//  MeMatchView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 21.02.21.
//

import SwiftUI

struct MeMatchView: View {
    
    @StateObject private var meMatchStartVM: MeMatchStartViewModel = MeMatchStartViewModel()
    
    @Binding var showMeMatchMainView: Bool
    @Binding var tappedEvent: EventModelObject
    
    // database data
    @State var likedUsers: [UserModelObject] = [stockUserObject]
    
    @State var userChosen: Bool = false
    @State var showMeMatchView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            ZStack {
                ForEach(likedUsers.indices, id: \.self ) { userNumber in
                    MeMatchCardView(userChosen: $userChosen, users: $likedUsers, user: likedUsers[userNumber], userNumber: userNumber, showMeMatchMainView: $showMeMatchMainView)
                        .opacity(showMeMatchView ? 1 : 0)
                }
            }
            
            MeMatchStartView(showMeMatchView: $showMeMatchView)
                .opacity(showMeMatchView ? 0 : 1)
        }
        .onAppear {
            meMatchStartVM.getLikedUsers(eventId: "81C40095-1C28-4B30-84F4-C105BE4A9C9B")
            likedUsers = meMatchStartVM.likedUsers
        }
    }
}

struct MeMatchView_Previews: PreviewProvider {
    static var previews: some View {
        MeMatchView(showMeMatchMainView: .constant(false), tappedEvent: .constant(stockEventObject), likedUsers: [stockUserObject, stockUserObject])
    }
}
