//
//  MeMatchView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 21.02.21.
//

import SwiftUI

struct MeMatchView: View {
    
    // database data
    @State var likedUsers: [UserModelObject] = [stockUserObject, stockUserObject]
    
    @State var userChosen: Bool = false
    @State var showMeMatchView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            ZStack {
                ForEach(likedUsers.indices, id: \.self ) { userNumber in
                    MeMatchCardView(userChosen: $userChosen, users: $likedUsers, user: likedUsers[userNumber], userNumber: userNumber)
                        .opacity(showMeMatchView ? 1 : 0)
                }
            }
            
            MeMatchStartView(showMeMatchView: $showMeMatchView)
                .opacity(showMeMatchView ? 0 : 1)
        }
    }
}

struct MeMatchView_Previews: PreviewProvider {
    static var previews: some View {
        MeMatchView(likedUsers: [stockUserObject, stockUserObject])
    }
}
