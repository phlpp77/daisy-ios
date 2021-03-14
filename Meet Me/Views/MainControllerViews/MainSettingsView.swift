//
//  MainSettingsView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainSettingsView: View {
    
    @Binding var startProcessDone: Bool
    @StateObject var meProfileVM: MeProfileViewModel = MeProfileViewModel()
    //@ObservedObject private var meProfileVM = MeProfileViewModel()
    

    var body: some View {
        
        ZStack {
            VStack {
                
                MeProfileNView()
                    .environmentObject(meProfileVM)
                    .onAppear{
                        meProfileVM.getCurrentUser()
                    }
                
            }
            
            LogoutView(startProcessDone: $startProcessDone)
                .offset(x: screen.width / 2 - (screen.width * 0.15), y: -screen.height / 2 + (screen.width * 0.22))
        }

    }
}

struct MainSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            MainSettingsView(startProcessDone: .constant(true))
        }
        
    }
}
