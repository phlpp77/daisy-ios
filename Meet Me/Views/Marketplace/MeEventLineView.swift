//
//  MeEventLineView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.02.21.
//

import SwiftUI

struct MeEventLineView: View {
    
    @StateObject private var youEventVM = YouEventViewModel()
    @State private var eventArray: [EventModelObject] = [stockEventObject, stockEventObject]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                // create a view for each event in the array
                ForEach(eventArray.indices, id: \.self) { event in
                    GeometryReader { geometry in
                        VStack {
                            YouEventView(eventModelObject: eventArray[event], eventArray: $eventArray, eventIndex: event, dragPossible: false)
                                .rotation3DEffect(
                                    // get new angle, move the min x 30pt more to the right and make the whole angle smaller with the / - 40
                                    Angle(
                                        degrees: Double(geometry.frame(in: .global).minX - 30) / -40),
                                        axis: (x: 0, y: 10, z: 0)
                                    )
                                .scaleEffect(0.5)
                            }
                    }
                    .frame(width: 200, height: 200)
                }
                // needed to refresh the ForEach after a change is made in the array
                .id(UUID())
                
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            youEventVM.getUserEvents()
            eventArray = youEventVM.event
        }
    }
}

struct MeEventLineView_Previews: PreviewProvider {
    static var previews: some View {
        MeEventLineView()
    }
}
