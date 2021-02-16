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
    //am besten dann funktion getUserEvent() über onAppear aufrufen

    //danach kann auf das Array auf das array über
    //eventCreationVM.event zugegriffen werden
    
    // data transfer form database
    @State private var eventArray: [EventModelObject] = [stockEventObject]
//    private var eventViewArray: [YouEventView] = [YouEventView(eventModelObject: stockEventObject), YouEventView(eventModelObject: stockEventObject)]
    
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
                        ForEach(eventArray.indices, id: \.self) { event in
                            GeometryReader { geometry in
                                VStack {
                                    YouEventView(eventModelObject: eventArray[event], eventArray: $eventArray, eventIndex: event)
                                        .rotation3DEffect(
                                            // get new angle, move the min x 30pt more to the right and make the whole angle smaller with the / - 40
                                            Angle(
                                                degrees: Double(geometry.frame(in: .global).minX - 30) / -40),
                                                axis: (x: 0, y: 10, z: 0)
                                            )
                                    }
                            }
                            .frame(width: 250, height: 250)
                            .padding(.bottom, 190)
                            .padding(.leading, 30)                                                        
                        }
                        // needed to refresh the ForEach after a change is made in the array
                        .id(UUID())
                        
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                Spacer()
            }
            .frame(height: 440)
            
        }
        .frame(height: 440)
        .onAppear {
            youEventVM.getUserEvents()
            print("events in the db")
            print(youEventVM.event)
            eventArray = youEventVM.event
        }
        
    }

    
}

struct EventLineView_Previews: PreviewProvider {
    static var previews: some View {
        EventLineView()
    }
}
