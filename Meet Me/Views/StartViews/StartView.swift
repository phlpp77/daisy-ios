//
//  StartView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.01.21.
//

import SwiftUI
////

struct StartView: View {
    
    // returns true when login or registration process is done
    @Binding var startProcessDone: Bool
    
    // for animation from welcomeView to RegisterView
    @State var showWelcomeView = true
    
    // for animation to loginView
    @State var showLoginView = false
    
    // user is logged in
    @State var userIsLoggedIn = false
    
    // user has no account
    @State var userHasNoAccount = true
    
    // animation to show the second line of text after the used read the first line
    @State var showSecondLine = false
    
    // animation to show the button to start
    @State var showStartButton = false
    
    var body: some View {
        
        ZStack {
            
            // apply backgroundcolor
            StartBackgroundView()
                .blur(radius: 1)
            
            // show the welcome message, the question and then the button to start
            WelcomeView(showWelcomeView: $showWelcomeView, showSecondLine: $showSecondLine, showStartButton: $showStartButton)
                // animate from welcome to register view
                .opacity(showWelcomeView ? 1 : 0)
            
            ProfileCreationView(profileCreationFinished: $startProcessDone)
                // animation from login to profile creation
                .opacity(userIsLoggedIn && userHasNoAccount ? 1 : 0)
            
            // show the register form
            RegisterView(showLoginView: $showLoginView, userIsLoggedIn: $userIsLoggedIn, userHasNoAccount: $userHasNoAccount)
                // animate from welcome to register view
                .opacity(showWelcomeView ? 0 : 1)
                // animation from register to login view
                .opacity(showLoginView ? 0 : 1)
                // animation from register to profile creation view
                .opacity(userIsLoggedIn ? 0 : 1)
            
            // show the login view
            LoginView(userIsLoggedIn: $userIsLoggedIn, userHasNoAccount: $userHasNoAccount)
                // animation from register to login view
                .opacity(showLoginView ? 1 : 0)
                // animation from login to profile creation
                .opacity(userIsLoggedIn ? 0 : 1)
            
            
        }
        .animation(.easeInOut)
        // animation of second textline starts
        .onTapGesture {
            
            
            // everytime the screen is tapped
            self.showSecondLine = true
            
            // when tapped the next button shows up after 0.1 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showStartButton = true
            }
            hapticPulse(feedback: .rigid)
        }
    }
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(startProcessDone: .constant(false))
    }
}

struct WelcomeView: View {
   
    // pass over the states from the StartView
    @Binding var showWelcomeView: Bool
    @Binding var showSecondLine: Bool
    @Binding var showStartButton: Bool
    
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 8) {
                    
                    // adding a different color to the name
                    HStack(spacing: 0) {
                        Text("Hello, ")
                        Text("Nameless")
                            .foregroundColor(.accentColor)
                        Text(".")
                    }
                    .font(.title)
                    
                    // question shows up after tap -> animation
                    Text(showSecondLine ? "Do you want to meet new people?" : "")
                        .font(.subheadline)
                    
                }
                .padding()
                .modifier(FrozenWindowModifier())
                .frame(maxHeight: .infinity)
                .animation(.easeInOut(duration: 1.0))
                
                Spacer()
                // start button shows the register view
                Button(action: {
                    showWelcomeView = false
 
                    
                }, label: {
                    HStack {
                        Text("Sure, let's go!")
                            .foregroundColor(.primary)
                        Image(systemName: "figure.walk")
                    }
                })
                .padding()
                .modifier(FrozenWindowModifier())
                .opacity(showStartButton ? 1 : 0.0)
                .scaleEffect(showStartButton ? 1 : 0.9)
                .animation(.easeInOut)
            }
        }
    }
}
