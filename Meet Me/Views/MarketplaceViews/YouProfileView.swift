//
//  YouProfileView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 26.02.21.
//

import SwiftUI

struct YouProfileView: View {
    
    @Binding var showYouProfileView: Bool
    
    var body: some View {
        
        ZStack {
            
            // MARK: Background (blurred)
            BlurView(style: .systemMaterial)
                .ignoresSafeArea()
                .onTapGesture {
                    showYouProfileView = false
                }
            
            // MARK: Profile shown
            MeProfileView(profileUsageType: .you)
                .modifier(FrozenWindowModifier())
        }
    }
}

struct YouProfileView_Previews: PreviewProvider {
    static var previews: some View {
        YouProfileView(showYouProfileView: .constant(true))
    }
}
