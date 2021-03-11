//
//  MeProfileNView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 11.03.21.
//

import SwiftUI

struct MeProfileNView: View {
    
    
    
    var body: some View {
        
        VStack {
            
            // MARK: Header
            HStack(spacing: 0.0) {
                Text("That's ")
                Text("ME")
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(.accentColor)
                Text("!")
            }
            .font(.largeTitle)
            .frame(width: 327, height: 53)
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(
                        LinearGradient(
                                    gradient: Gradient(stops: [
                                .init(color: Color(#colorLiteral(red: 0.7791666388511658, green: 0.7791666388511658, blue: 0.7791666388511658, alpha: 0.949999988079071)), location: 0),
                                .init(color: Color(#colorLiteral(red: 0.7250000238418579, green: 0.7250000238418579, blue: 0.7250000238418579, alpha: 0)), location: 1)]),
                                    startPoint: UnitPoint(x: 0.9016393067273221, y: 0.10416647788375455),
                                    endPoint: UnitPoint(x: 0.035519096038869824, y: 0.85416653880629)),
                        lineWidth: 0.5
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            
            
            Spacer()
            
            // MARK: First block (look of the user)
            MeProfileFirstBlockView()
            
            Spacer()
            
            // MARK: Second block (change the search-settings)
            MeProfileSecondBlockView()
            
            Spacer()
        }
        
    }
}

struct MeProfileNView_Previews: PreviewProvider {
    static var previews: some View {
        MeProfileNView()
    }
}
