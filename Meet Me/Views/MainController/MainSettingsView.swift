//
//  MainSettingsView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainSettingsView: View {
    
    var user: UserModel = testUser
    @ObservedObject private var meProfileVM = MeProfileViewModel()

    
    
  
    
  
    
    
    
    var body: some View {
        
        MeProfileView(user: meProfileVM.userModel, URL: meProfileVM.userPictureURL)
            .onAppear {
                meProfileVM.getUser()
                meProfileVM.getUserProfilePictureURL()
            }
    }
}

struct MainSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MainSettingsView()
    }
}
