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
    
    var body: some View {
        ZStack {
            VStack {
                
                Button("New Event") {
                    showCreationView.toggle()
                }
                
                Text("Meet Me Market")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 50)
                
                MeEventLineView()
                
                EventLineView()
            }
            
            // create the setup EventView on top of the rest
            if showCreationView {
                EventCreationView(presentation: $showCreationView)
            }
        }
    }
}

struct MainExploreView_Previews: PreviewProvider {
    static var previews: some View {
        MainExploreView()
    }
}
