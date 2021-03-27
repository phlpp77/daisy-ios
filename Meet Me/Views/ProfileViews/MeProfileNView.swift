//
//  MeProfileNView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 11.03.21.
//

import SwiftUI

struct MeProfileNView: View {
    
    @State var showDeveloperView: Bool = false
    
    var body: some View {
        
        VStack {
            
            // Header
            HeaderView()
                .onTapGesture {
                    showDeveloperView = true
                }
            
            
            Spacer()
            
            // First block (look of the user)
            MeProfileFirstBlockView()
            
            Spacer()
            
            // Second block (change the search-settings)
            MeProfileSecondBlockView()
            
            Spacer()
        }
        .sheet(isPresented: $showDeveloperView, content: {
            DeveloperView()
        })
        
    }
}

struct MeProfileNView_Previews: PreviewProvider {
    static var previews: some View {
        MeProfileNView()
    }
}
