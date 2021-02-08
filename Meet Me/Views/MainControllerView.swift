//
//  MainControllerView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainControllerView: View {
    var body: some View {
        TabView {
            MainExploreView.tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
        }
    }
}

struct MainControllerView_Previews: PreviewProvider {
    static var previews: some View {
        MainControllerView()
    }
}
