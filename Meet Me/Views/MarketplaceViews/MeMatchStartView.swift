//
//  MeMatchStartView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 18.02.21.
//

import SwiftUI

struct MeMatchStartView: View {
    
    @State var buttonPressed: Bool = false
    @Binding var showMeMatchView: Bool
    
    var body: some View {
        ZStack {
            
            // MARK: Background (blurred)
            BlurView(style: .systemMaterial)
                .ignoresSafeArea()
                .onTapGesture {
                    showMeMatchView = false
                }
            
            VStack {
                
                // MARK: heading
                Text("Meet Me Market")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 12)
                    .padding(.top, 16)

                
                // MARK: start-question
                Text("Ready to find your Meeter?")
                
                Spacer()
                
                // MARK: animation / image
//                Image(systemName: "at.badge.plus")
//                    .font(.system(size: 120))
                LottieView(filename: "heard-loading", loopMode: .autoReverse)
                    .frame(width: 200, height: 200, alignment: .center)
                
                Spacer()
                
                // MARK: start button
                Text("Let's go")
                    .opacity(buttonPressed ? 0.5 : 1)
                    .padding()
                    .modifier(FrozenWindowModifier())
                    .padding(.bottom, 16)
                    .scaleEffect(buttonPressed ? 0.8 : 1)
                    .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
                    .onTapGesture {
                        // button animation start
                        buttonPressed.toggle()
                        
                        // haptic feedback when button is tapped
                        hapticPulse(feedback: .rigid)
                        
                        // start process
                        // TODO: fill in hand-over to start-process
                    }
                
            }
            .frame(width: 340, height: 620, alignment: .center)
            .modifier(FrozenWindowModifier())
        }
    }
}

struct MeMatchStartView_Previews: PreviewProvider {
    static var previews: some View {
        MeMatchStartView(showMeMatchView: .constant(true))
    }
}
