//
//  MainExploreView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainExploreView: View {
    var body: some View {
        VStack {
            Text("Everything to find meets is here")
            Text("Meet Me Market")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
        }
    }
}

struct MainExploreView_Previews: PreviewProvider {
    static var previews: some View {
        MainExploreView()
    }
}
