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
    
    @State var showCheckView: Bool = false

    var body: some View {
        
        GeometryReader { bounds in
            ZStack {
                VStack {
                    
                    MeProfileNView()
                        .environmentObject(meProfileVM)
                        .onAppear{
                            meProfileVM.getCurrentUser()
                        }
                    
                }
                
                LogoutView(startProcessDone: $startProcessDone, showCheck: $showCheckView)
                    .offset(x: bounds.size.width / 2 - (bounds.size.width * 0.15), y: -bounds.size.height / 2 + (bounds.size.width * 0.22))
                    
                
                CheckView(showCheckView: $showCheckView, text: "Logged out")
                    .onDisappear {
                        startProcessDone = false
                    }
                
            }
            .frame(width: bounds.size.width, height: bounds.size.height, alignment: .center)
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
