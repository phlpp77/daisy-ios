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
            VStack {
                
                // MARK: Title
                HStack(spacing: 0.0) {
                    Text("That's ")
                    Text("ME")
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.accentColor)
                    Text("!")
                        
                }
                .font(.largeTitle)
                .padding(.vertical, 12)
                
                
                // MARK: Profile details
                MeProfileView()
                
                Spacer()
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
