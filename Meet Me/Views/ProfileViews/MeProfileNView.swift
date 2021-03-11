//
//  MeProfileNView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 11.03.21.
//

import SwiftUI

struct MeProfileNView: View {
    
    
    
    var body: some View {
        
        // MARK: - First block (look of the user)
        VStack {
            
            // MARK: Title of first block
            HStack(spacing: 0.0) {
                Text("The way ")
                Text("ME")
                    .foregroundColor(.accentColor)
                Text(" look")
            }
            .font(.title3)
            
            
            HStack {
                VStack {
                    PictureCircle(isProfilePicture: true)
                    PictureCircle(isProfilePicture: false)
                }
                PictureCircle(isProfilePicture: false)
            }
            
        }
        
       
    }
}

struct MeProfileNView_Previews: PreviewProvider {
    static var previews: some View {
        MeProfileNView()
    }
}

struct PictureCircle: View {
    
    var isProfilePicture: Bool
    
    var body: some View {
        
        ZStack {
            // MARK: Background Blur
            BlurView(style: .systemUltraThinMaterial)
                .frame(width: 109, height: 109)
                .overlay(
                    Circle()
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
                .clipShape(Circle())
            
            // MARK: Extra blueish circle when is used as profile picture
            if isProfilePicture {
                Circle()
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                                .init(color: Color(#colorLiteral(red: 0.9490196108818054, green: 0.9490196108818054, blue: 0.9490196108818054, alpha: 1)), location: 0),
                                                .init(color: Color(#colorLiteral(red: 0.0313725508749485, green: 0.45490196347236633, blue: 0.5490196347236633, alpha: 1)), location: 0.53125)]),
                            startPoint: UnitPoint(x: 1, y: 0),
                            endPoint: UnitPoint(x: 1.7763568394002505e-15, y: 1.0000000596046466)),
                        lineWidth: 5
                    )
                    .frame(width: 109, height: 109)
            }
            
            // MARK: Actual Image
            // FIXME: need to be changed to URLImage
            Image("Philipp")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 91, height: 91)
                .clipShape(Circle())
        }
    }
}
