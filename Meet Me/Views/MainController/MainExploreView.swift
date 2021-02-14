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
    @State private var showCreationView: Bool = true
    
    var body: some View {
        VStack {
            
            Button("New Event") {
                showCreationView = true
            }
            
            Text("Meet Me Market")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
                .padding(.bottom, 50)
            
            if showCreationView {
                EventCreationView(presentation: $showCreationView)
            }
            

            
//            EventLineView()
        }
    }
}

struct MainExploreView_Previews: PreviewProvider {
    static var previews: some View {
        MainExploreView()
    }
}
