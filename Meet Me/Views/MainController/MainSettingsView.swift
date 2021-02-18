//
//  MainSettingsView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainSettingsView: View {
    
    @ObservedObject private var meProfileVM = MeProfileViewModel()
    
    var body: some View {
        
        MeProfileView(user: meProfileVM.userModel, URL: meProfileVM.userPictureURL)
            .onAppear {
                meProfileVM.fillUserModel()
                meProfileVM.getUserProfilePictureURL()
            }
    }
}

struct MainSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MainSettingsView()
    }
}
