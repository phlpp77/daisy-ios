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
    @State private var showMeMatchView: Bool = false
    @State private var showYouProfileView: Bool = false
    
    @State private var eventArray: [EventModelObject] = [stockEventObject, stockEventObject]
    @State private var tappedMeEvent: EventModelObject = stockEventObject
    @State private var tappedYouEvent: EventModelObject = stockEventObject
    
    var body: some View {
        ZStack {
            VStack {
                
                HStack(spacing: 0.0) {
                    Text("Meet ")
                    Text("ME")
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.accentColor)
                    Text(" Market")
                }
                .font(.largeTitle)
                .padding(.vertical, 12)
                
                Text("Me Events")
                    .font(.subheadline)
                    .bold()
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
                
                MeEventLineView(showCreationView: $showCreationView, showMeMatchView: $showMeMatchView, tappedEvent: $tappedMeEvent)
                
                Text("You Events")
                    .font(.subheadline)
                    .bold()
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
                
                YouEventLineView(tappedYouEvent: $tappedYouEvent, showYouProfileView: $showYouProfileView)
            }
            
            // create the setup EventView on top of the rest
            if showCreationView {
                EventCreationView(presentation: $showCreationView, eventArray: $eventArray)
            }
            
            // start the MeMatch process
            if showMeMatchView {
                MeMatchView(showMeMatchMainView: $showMeMatchView, tappedEvent: $tappedMeEvent)
            }
            
            if showYouProfileView {
                YouProfileView(showYouProfileView: $showYouProfileView, tappedYouEvent: $tappedYouEvent)
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
