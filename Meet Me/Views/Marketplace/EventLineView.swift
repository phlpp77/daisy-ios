//
//  EventLineView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.02.21.
//

import SwiftUI

struct EventLineView: View {
    
    @State var position: CGSize = .zero
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0 ..< 5) { item in
                        GeometryReader { geometry in
                            VStack {
                                YouEventView()
                                    .rotation3DEffect(
                                        // get new angle, move the min x 30pt more to the right and make the whole angle smaller with the / - 40
                                        Angle(
                                            degrees: Double(geometry.frame(in: .global).minX - 30) / -40),
                                            axis: (x: 0, y: 10, z: 0)
                                        )
    //                                .scaleEffect(CGSize(width: 1.0, height: 1.0))
                                    .offset(x: position.width, y: position.height)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                position = value.translation
                                                
                                            }
                                            .onEnded { value in
                                               position = .zero
                                            }
                                    )
                            
    //                            Text(
    //                                String(
    ////                                    Double(geometry.frame(in: .global).minX - 100) / -10
    //                                    Double(geometry.size.width)
    //                                )
    //                            )
                                }
                                
                        }
                        .frame(width: 250, height: 250)
                        .padding(.bottom, 35)
                        .padding(.leading, 30)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
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
                
        }
        .frame(height: 400)
        
    }
}

struct EventLineView_Previews: PreviewProvider {
    static var previews: some View {
        EventLineView()
    }
}
