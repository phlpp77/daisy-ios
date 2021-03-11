//
//  MainStartView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.03.21.
//

import SwiftUI

struct MainStartView: View {
    
    @Binding var startUpDone: Bool
    
    @State var currentPosition: StartPosition = .splash
    
    var startPosition = [StartPosition.splash, StartPosition.onboarding, StartPosition.registerLogin, StartPosition.profileCreation]
    
    var body: some View {
        
        ZStack {
            
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            switch currentPosition {
            case .splash:
                SplashView(currentPosition: $currentPosition)
            case .onboarding:
                EmptyView()
            case .registerLogin:
                LoginNView(nextPosition: $currentPosition, startUpDone: $startUpDone)
            case .profileCreation:
                ProfileCreationView(profileCreationFinished: $startUpDone)
            }

        }
        
    }
}

struct MainStartView_Previews: PreviewProvider {
    static var previews: some View {
        MainStartView(startUpDone: .constant(false))
    }
}
