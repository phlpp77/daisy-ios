//
//  MainStartView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.03.21.
//

import SwiftUI

struct MainStartView: View {
    
    @StateObject var firstActions: FirstActions = FirstActions()
    
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
                OnboardingController(showOnboarding: $currentPosition)
            case .registerLogin:
                LoginNView(nextPosition: $currentPosition, startUpDone: $startUpDone)
            case .profileCreation:
                ProfileCreationView(profileCreationFinished: $startUpDone)
            }
            
        }
        .onAppear {
            if firstActions.firstViews["FirstStartUp"] == false || firstActions.firstViews["FirstStartUp"] == nil {
                currentPosition = .splash
                // update variable to true that user does not see the info again
                firstActions.firstViews["FirstStartUp"] = true
                // save the status to the phone
                firstActions.save()
            } else {
                currentPosition = .registerLogin
            }
            
        }
        
    }
}

struct MainStartView_Previews: PreviewProvider {
    static var previews: some View {
        MainStartView(startUpDone: .constant(false))
    }
}
