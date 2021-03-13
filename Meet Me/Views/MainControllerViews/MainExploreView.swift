//
//  MainExploreView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainExploreView: View {
    
    // create VM here for market and co
    
    // states for animation
    @State private var showCreationView: Bool = false
    @State private var showMeEventController: Bool = false
    @State private var showYouProfileView: Bool = false
    
    @State private var eventArray: [EventModel] = [stockEvent, stockEvent]
    @State private var tappedMeEvent: EventModel = stockEvent
    @State private var tappedYouEvent: EventModel = stockEvent
    
    var body: some View {
        ZStack {
            
            VStack {
                
                HeaderView(text1: "Meet ", text2: " Market", highlightText: "ME")
                
                if !showYouProfileView && !showMeEventController {
                    VStack {
                        
                        Text("Me Events")
                            .font(.subheadline)
                            .bold()
                            .textCase(.uppercase)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 12)
                        
                        MeEventLineView(showCreationView: $showCreationView, showMeMatchView: $showMeEventController, tappedEvent: $tappedMeEvent)
                        
                        Text("You Events")
                            .font(.subheadline)
                            .bold()
                            .textCase(.uppercase)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 12)
                        
                        YouEventLineView(tappedYouEvent: $tappedYouEvent, showYouProfileView: $showYouProfileView)
                    }
//                    .opacity(showYouProfileView ? 0 : 1)
//                    .opacity(showMeEventController ? 0 : 1)
                }
                
                
            }
            
            // create the setup EventView on top of the rest
            if showCreationView {
                EventCreationView(presentation: $showCreationView, eventArray: $eventArray)
            }
            
            // start the MeMatch process
            if showMeEventController {
                MeEventControllerView(showMeEventControllerView: $showMeEventController, tappedEvent: $tappedMeEvent)
            }
            
            // MARK: Show youProfileView when user taps on a YouEvent
            if showYouProfileView {
                YouProfileNView(showYouProfileView: $showYouProfileView, event: $tappedYouEvent)
            }
        }
    }
}

struct MainExploreView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            MainExploreView()
        }
    }
}
