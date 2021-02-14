//
//  MainExploreView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainExploreView: View {
    
    // create VM here for market and co
    
    
    var body: some View {
        VStack {
            Text("Meet Me Market")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
                .padding(.bottom, 50)
            
            EventLineView()
        }
    }
}

struct MainExploreView_Previews: PreviewProvider {
    static var previews: some View {
        MainExploreView()
    }
}
