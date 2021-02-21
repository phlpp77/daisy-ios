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
    
    @State private var tappedEvent: EventModelObject = stockEventObject
    
    var body: some View {
        ZStack {
            VStack {
                
                Text("Meet Me Market")
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 12)
                
                Text("Me Events")
                    .font(.subheadline)
                    .bold()
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
                
                MeEventLineView(showCreationView: $showCreationView, showMeMatchView: $showMeMatchView, tappedEvent: $tappedEvent)
                
                Text("You Events")
                    .font(.subheadline)
                    .bold()
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
                
                EventLineView()
            }
            
            // create the setup EventView on top of the rest
            if showCreationView {
                EventCreationView(presentation: $showCreationView)
            } else if showMeMatchView {
                MeMatchView(showMeMatchMainView: $showMeMatchView, tappedEvent: $tappedEvent)
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
