//
//  EventLineView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.02.21.
//

import SwiftUI

struct EventLineView: View {
    
    @State var dragPosition: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            Color.white
                .frame(width: 150, height: 150, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(style: StrokeStyle(
                            lineWidth: 2,
                            dash: [15]
                        ))
                        .foregroundColor(Color.black.opacity(0.5))
                )
                .offset(y: 140)
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(0 ..< 5) { item in
                            GeometryReader { geometry in
                                VStack {
                                    YouEventView(dragPosition: $dragPosition)
                                        .rotation3DEffect(
                                            // get new angle, move the min x 30pt more to the right and make the whole angle smaller with the / - 40
                                            Angle(
                                                degrees: Double(geometry.frame(in: .global).minX - 30) / -40),
                                                axis: (x: 0, y: 10, z: 0)
                                            )
        //                                .scaleEffect(CGSize(width: 1.0, height: 1.0))
                                        .offset(x: dragPosition.width, y: dragPosition.height)
                                                                        
        //                            Text(
        //                                String(
        ////                                    Double(geometry.frame(in: .global).minX - 100) / -10
        //                                    Double(geometry.size.width)
        //                                )
        //                            )
                                    }
                                    
                            }
                            .frame(width: 250, height: 250)
                            .padding(.bottom, 190)
                            .padding(.leading, 30)
                                                        
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                Spacer()
            }
            .frame(height: 440)
            
        }
        .frame(height: 440)
        
    }
}

struct EventLineView_Previews: PreviewProvider {
    static var previews: some View {
        EventLineView()
    }
}
