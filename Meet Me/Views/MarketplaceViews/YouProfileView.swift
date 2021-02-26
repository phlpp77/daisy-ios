//
//  YouProfileView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 26.02.21.
//

import SwiftUI

struct YouProfileView: View {
    
    var body: some View {
        
        MeProfileView(totalHeight: 620)
            .modifier(FrozenWindowModifier())
    }
}

struct YouProfileView_Previews: PreviewProvider {
    static var previews: some View {
        YouProfileView()
    }
}
