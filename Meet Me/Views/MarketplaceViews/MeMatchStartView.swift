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
    
    // getting information on the eventStatus
    @Binding var event: EventModelObject
    @State var eventStatus: EventStatus = .liked
    
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
                Text(eventStatus == .matched ? "You already have a Meeter, go to Chats to set the details!" : eventStatus == .liked ? "Ready to find your Meeter?" : "Wait a bit that other Meeters can find YOUr Event")
               
                // MARK: Show the like count (if premium)
                if eventStatus == .liked {
                    HStack(alignment: .top) {
                        Text("Number of likes:")
                        Text("Grade up your Meeter to GOLDY to see how many likes you got")
                            .font(.caption)
                    }
                    .padding(.vertical, 10)
                }
                
                Spacer()
                
                // MARK: animation / image
                // FIXME: loopMode not working, playOnce just does not work
                LottieView(filename: "heard-loading", loopMode: eventStatus == .matched ? .playOnce : .autoReverse)
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
                .disabled(eventStatus == .matched ? true : eventStatus == .notLiked ? true : false)
                .opacity(eventStatus == .matched ? 0.6 : eventStatus == .notLiked ? 0.6 : 1)
                
                
                
            }
            .animation(.easeInOut)
            .padding()
            .frame(width: 340, height: 620, alignment: .center)
            .modifier(FrozenWindowModifier())
        }
//        .onAppear {
//            if event.eventMatched {
//                eventStatus = .matched
//            } else if event.likedUser {
//                eventStatus = .liked
//            } else {
//                eventStatus = .notLiked
//            }
//        }
        
    }
}

struct MeMatchStartView_Previews: PreviewProvider {
    static var previews: some View {
        MeMatchStartView(showMeMatchView: .constant(true), showMeMatchMainView: .constant(true), event: .constant(stockEventObject), likedUsers: .constant([stockUserObject]))
    }
}
