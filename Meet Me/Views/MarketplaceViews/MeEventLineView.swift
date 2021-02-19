//
//  MeEventLineView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.02.21.
//

import SwiftUI

struct MeEventLineView: View {
    
    @StateObject private var meEventLineVM = MeEventLineViewModel()
    @State private var eventArray: [EventModelObject] = [stockEventObject, stockEventObject, stockEventObject, stockEventObject]
    
    @State var buttonPressed: Bool = true
    @Binding var showCreationView: Bool
    
    var body: some View {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .padding(10)
                            .background(BlurView(style: .systemMaterial))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                            .padding(.leading, 10)
                            .scaleEffect(buttonPressed ? 0.8 : 1)
                            .opacity(buttonPressed ? 0.5 : 1)
                            .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
                            .onTapGesture {
                                // button animation start
                                buttonPressed.toggle()
                                
                                // haptic feedback when button is tapped
                                hapticPulse(feedback: .rigid)
                                
                                // close view
                                showCreationView = true
                            }
                            
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
                                    .frame(width: 140, height: 160, alignment: .center)
                            }
                        }
                    }
                }
            }        
            .onAppear {
                meEventLineVM.getMeEvents()
                eventArray = meEventLineVM.meEvents
                
                print("DEBUG: ALLMeEvents\(eventArray)")
        }
    }
}

struct MeEventLineView_Previews: PreviewProvider {
    static var previews: some View {
        MeEventLineView(showCreationView: .constant(false))
    }
}