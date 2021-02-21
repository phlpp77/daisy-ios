//
//  MeMatchView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 21.02.21.
//

import SwiftUI

struct MeMatchView: View {
    
    @Binding var showMeMatchMainView: Bool
    
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
    }
}

struct MeMatchView_Previews: PreviewProvider {
    static var previews: some View {
        MeMatchView(showMeMatchMainView: .constant(false), likedUsers: [stockUserObject, stockUserObject])
    }
}
