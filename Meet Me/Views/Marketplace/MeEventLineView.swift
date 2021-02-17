//
//  MeEventLineView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.02.21.
//

import SwiftUI

struct MeEventLineView: View {
    
    @StateObject private var youEventVM = YouEventViewModel()
    @State private var eventArray: [EventModelObject] = [stockEventObject, stockEventObject, stockEventObject, stockEventObject]
    
    var body: some View {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(eventArray.indices, id: \.self) { event in
                            HStack {
                                //
                                YouEventView(eventModelObject: eventArray[event], eventArray: $eventArray, eventIndex: event, dragPossible: false)
                                    .rotation3DEffect(
                                        // get new angle, move the min x 30pt more to the right and make the whole angle smaller with the / - 40
                                        Angle(
                                            degrees: Double(geometry.frame(in: .global).minX - 30) / -40),
                                            axis: (x: 0, y: 10, z: 0)
                                        )
                                    .scaleEffect(0.5)
                                    .frame(width: 140, height: 140, alignment: .center)
                            }
                        }
                    }
                }
            }        
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
