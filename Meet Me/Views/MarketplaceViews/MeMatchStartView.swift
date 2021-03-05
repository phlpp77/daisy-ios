//
//  MeMatchStartView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 18.02.21.
//

import SwiftUI

struct MeMatchStartView: View {
    
    @State var buttonPressed: Bool = false
    // start the matching
    @Binding var showMeMatchView: Bool
    // the whole match view
    @Binding var showMeMatchMainView: Bool
    // user has already a match on this event
    var eventMatched: Bool = true
    @State var eventIsMatched: Bool = false
    
    @Binding var likedUsers : [UserModelObject]
    @StateObject private var meMatchStartVM : MeMatchStartViewModel = MeMatchStartViewModel()
    
    var body: some View {
        ZStack {
            
            // TODO: FIX the background to the main screen
            // MARK: Background (blurred)
            BlurView(style: .systemMaterial)
                .ignoresSafeArea()
                .onTapGesture {
                    print("cancel me match tapped")
                    showMeMatchMainView = false
                }
            
            VStack {
                
                // MARK: heading
                Text("Meet Me Market")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 12)
                    .padding(.top, 16)

                
                // MARK: start-question
                Text(eventIsMatched ? "You already have a Meeter, go to Chats to set the details!" : "Ready to find your Meeter?")
                    .padding()
                
                Spacer()
                
                // MARK: animation / image
//                Image(systemName: "at.badge.plus")
//                    .font(.system(size: 120))
                LottieView(filename: "heard-loading", loopMode: eventIsMatched ? .playOnce : .autoReverse)
                    .frame(width: 200, height: 200, alignment: .center)
                
                Spacer()
                
                
                // MARK: start button
                
                Button(action: {
                    // button animation start
                    buttonPressed.toggle()
                    
                    // show me match view now
                    if likedUsers.count != 0 {
                        print("no matches - no match view")
                        showMeMatchView = true
                    } else {
                        showMeMatchMainView = false
                    }
                    
                    // haptic feedback when button is tapped
                    hapticPulse(feedback: .rigid)
                }, label: {
                    Text("Let's go")
                        .opacity(buttonPressed ? 0.5 : 1)
                        .padding()
                        .modifier(FrozenWindowModifier())
                        .padding(.bottom, 16)
                        .scaleEffect(buttonPressed ? 0.8 : 1)
                        .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
                })
                .disabled(eventIsMatched)
                .opacity(eventIsMatched ? 0.6 : 1)
                
                
                
            }
            .animation(.easeInOut)
            .frame(width: 340, height: 620, alignment: .center)
            .modifier(FrozenWindowModifier())
        }
        .onAppear {
            eventIsMatched = eventMatched
        }
        
    }
}

struct MeMatchStartView_Previews: PreviewProvider {
    static var previews: some View {
        MeMatchStartView(showMeMatchView: .constant(true), showMeMatchMainView: .constant(true), likedUsers: .constant([stockUserObject]))
    }
}
