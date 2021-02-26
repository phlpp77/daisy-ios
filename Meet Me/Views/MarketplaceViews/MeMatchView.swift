//
//  MeMatchView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 21.02.21.
//

import SwiftUI
import PromiseKit
struct MeMatchView: View {
    
    @StateObject private var meMatchStartVM: MeMatchStartViewModel = MeMatchStartViewModel()
    
    @Binding var showMeMatchMainView: Bool
    @Binding var tappedEvent: EventModelObject
    
    // database data
    @State var likedUsers: [UserModelObject] = [stockUserObject]
    
    // local data
    @State var userChosen: Bool = false
    @State var showMeMatchView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            ZStack {
                ForEach(likedUsers.indices, id: \.self ) { userNumber in
                    MeMatchCardView(userChosen: $userChosen, users: $likedUsers, event: $tappedEvent, user: likedUsers[userNumber], userNumber: userNumber, showMeMatchMainView: $showMeMatchMainView)
                        .opacity(showMeMatchView ? 1 : 0)
                }
            }
            
            MeMatchStartView(showMeMatchView: $showMeMatchView, showMeMatchMainView: $showMeMatchMainView, likedUsers: $likedUsers)
                .opacity(showMeMatchView ? 0 : 1)
        }
        .onAppear {
            firstly {
                self.meMatchStartVM.getLikedUsers(eventId: tappedEvent.eventId)
            }.done { user in
                self.likedUsers = user
            }.catch { error in
                print("DEBUG: error in GetYouEventChain: \(error)")
                print("DEBUG: \(error.localizedDescription)")
            }
        }
    }
}

struct MeMatchView_Previews: PreviewProvider {
    static var previews: some View {
        MeMatchView(showMeMatchMainView: .constant(false), tappedEvent: .constant(stockEventObject), likedUsers: [stockUserObject, stockUserObject])
    }
}
