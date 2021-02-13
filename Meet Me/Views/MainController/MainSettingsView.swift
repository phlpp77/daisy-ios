//
//  MainSettingsView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainSettingsView: View {
    
    var user: UserModel = testUser
    @ObservedObject private var userListVM = UserListModel()

    
    
  
    
  
    
    
    
    var body: some View {
        
        MeProfileView(user: userListVM.userModel)
            .onAppear {
                userListVM.getUser()
            }
    }
}

struct MainSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MainSettingsView()
    }
}
