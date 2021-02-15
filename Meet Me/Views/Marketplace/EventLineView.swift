//
//  EventLineView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.02.21.
//

import SwiftUI

struct EventLineView: View {
    
    // data transfer form database
    private var eventArray: [EventModelObject] = [stockEventObject, stockEventObject, stockEventObject]
//    private var eventViewArray: [YouEventView] = [YouEventView(eventModelObject: stockEventObject), YouEventView(eventModelObject: stockEventObject)]
    
    @State var dragPosition: CGSize = .zero
    @State var position: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            // dashed rectangle for dragging
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
            
            // horizontal event list
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        
                        // create a view for each event in the array
                        ForEach(eventArray, id: \.eventId) { event in
                            GeometryReader { geometry in
                                VStack {
                                    YouEventView(dragPosition: $dragPosition, eventModelObject: event)
                                        .rotation3DEffect(
                                            // get new angle, move the min x 30pt more to the right and make the whole angle smaller with the / - 40
                                            Angle(
                                                degrees: Double(geometry.frame(in: .global).minX - 30) / -40),
                                                axis: (x: 0, y: 10, z: 0)
                                            )
                                        .gesture(
                                            DragGesture()
                                                .onChanged { value in
                                                    print("changed position")
//                                                    event.position = value.translation
                                                    dragPosition = value.translation
                                                    print(value.translation)
//                                                    print(event.position)
                                                    print(dragPosition)
                                                    
                                                }
                                                .onEnded { value in
                                                    print("ended")
//                                                    event.position = .zero
                                                    dragPosition = .zero
                                                }
                                        )
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
