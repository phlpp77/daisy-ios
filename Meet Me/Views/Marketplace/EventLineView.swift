//
//  EventLineView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.02.21.
//

import SwiftUI

struct EventLineView: View {
    
    //Muss in die View
    @StateObject private var youEventVM = YouEventViewModel()
    
    // data transfer form database
    @State private var eventArray: [EventModelObject] = [stockEventObject, stockEventObject, stockEventObject]
    
    var body: some View {
        ZStack {
            
            // dashed rectangle for dragging
            Color.white
                .frame(width: 150, height: 50, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(style: StrokeStyle(
                            lineWidth: 2,
                            dash: [10]
                        ))
                        .foregroundColor(Color.black.opacity(0.5))
                )
                .offset(y: 150)
            
            // horizontal event list
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        
                        // create a view for each event in the array
                        ForEach(eventArray.indices, id: \.self) { event in
                            GeometryReader { geometry in
                                VStack {
                                    YouEventView(eventModelObject: eventArray[event], eventArray: $eventArray, eventIndex: event, dragPossible: true)
                                        .rotation3DEffect(
                                            // get new angle, move the min x 30pt more to the right and make the whole angle smaller with the / - 40
                                            Angle(
                                                degrees: Double(geometry.frame(in: .global).minX - 30) / -40),
                                                axis: (x: 0, y: 10, z: 0)
                                            )
                                    }
                            }
                            .frame(width: 250, height: 250)
                            .padding(.bottom, 120)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                        }
                        // needed to refresh the ForEach after a change is made in the array
                        .id(UUID())
                        
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                Spacer()
            }
            .frame(height: 380)
            
        }
        .frame(height: 380)
        .onAppear {
            youEventVM.getUserEvents()
            print("events in the db")
            print(youEventVM.event)
//            eventArray = youEventVM.event
        }
        
    }

    
}

struct EventLineView_Previews: PreviewProvider {
    static var previews: some View {
        EventLineView()
    }
}
