//
//  ContentView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.01.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("MeetMe")
            .padding()
            .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
            .background(Color(#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)))
    }
}
// 09.01.2021
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
