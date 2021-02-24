//
//  MainSettingsView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainSettingsView: View {
    
    @Binding var startProcessDone: Bool
    
    @ObservedObject private var meProfileVM = MeProfileViewModel()
    
    var body: some View {
        
        ZStack {
            MeProfileView()
            
            LogoutView(startProcessDone: $startProcessDone)
                .offset(x: screen.width / 2 - 60, y: -screen.height / 2 + 80)
        }

    }
}

struct MainSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MainSettingsView(startProcessDone: .constant(true))
    }
}
