//
//  StartView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.01.21.
//

import SwiftUI

struct StartView: View {
    
    // animation to show the second line of text after the used read the first line
    @State var showSecondLine = false
    
    // animation to show the button to start
    @State var showStartButton = false
    
    var body: some View {
        
        ZStack {
            
            // apply backgroundcolor
            StartBackgroundView()
                .blur(radius: 1)
            
            WelcomeView(showSecondLine: $showSecondLine, showStartButton: $showStartButton)
        }
        // animation of second textline starts
        .onTapGesture {
            // when tapped the second time the next button shows up after 0.5 seconds
            if showSecondLine {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showStartButton = true
                }
            }
            
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
    @Binding var showSecondLine: Bool
    @Binding var showStartButton: Bool
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    Text("Hallo, ")
                    Text("Namenloser")
                        .foregroundColor(.accentColor)
                    Text(".")
                }
                .font(.title)
                
                
                Text(showSecondLine ? "Willst du neue Leute kennenlernen?" : "")
                    .font(.subheadline)
                
            }
            .padding()
            .background(BlurView(style: .systemThinMaterial))
            // create a border line which is in the same size as the rounded Rectangle
            .overlay(
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .stroke(Color.white.opacity(0.6), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 10, y: 10)
            .animation(.easeInOut(duration: 1.0))
            
            Button(action: {                    
//                        .background(StartBackgroundView())
                
            }, label: {
                HStack {
                    Text("Klar, let's go!")
                        .foregroundColor(.primary)
                    Image(systemName: "figure.walk")
                }
            })
            .padding()
            .background(BlurView(style: .systemThinMaterial))
            // create a border line which is in the same size as the rounded Rectangle
            .overlay(
                RoundedRectangle(cornerRadius: 18.0, style: .continuous)
                    .stroke(Color.white.opacity(0.6), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 18.0, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 10, y: 10)
            .opacity(showStartButton ? 1 : 0.0)
            .scaleEffect(showStartButton ? 1 : 0.9)
            .animation(.easeInOut)
            .offset(y: 200)
            
        }
    }
}
