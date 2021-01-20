//
//  StartView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.01.21.
//

import SwiftUI
///

struct StartView: View {
    
    @State var showWelcomeView = true
    
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
            WelcomeView(showWelcomeView: $showWelcomeView, showSecondLine: $showSecondLine, showStartButton: $showStartButton).opacity(showWelcomeView ? 1 : 0)
            
            // show the register form
            RegisterView().opacity(showWelcomeView ? 0 : 1)
        }
        .animation(.easeInOut)
        // animation of second textline starts
        .onTapGesture {
            // when tapped the second time the next button shows up after 0.5 seconds
            if showSecondLine {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showStartButton = true
                }
            }
            // everytime the screen is tapped
            self.showSecondLine = true
            hapticPulse(feedback: .rigid)
        }
    }
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
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
                        Text("Hallo, ")
                        Text("Namenloser")
                            .foregroundColor(.accentColor)
                        Text(".")
                    }
                    .font(.title)
                    
                    // question shows up after tap -> animation
                    Text(showSecondLine ? "Willst du neue Leute kennenlernen?" : "")
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
                        Text("Klar, let's go!")
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
