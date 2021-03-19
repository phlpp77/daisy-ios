//
//  MeEventLineView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.02.21.
//

import SwiftUI
import PromiseKit

struct MeEventLineView: View {
    
    @StateObject private var meEventLineVM = MeEventLineViewModel()
    
    
    @State var buttonPressed: Bool = true
    
    @Binding var showCreationView: Bool
    @Binding var showMeMatchView: Bool
    
    @Binding var tappedEvent: EventModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20.0) {
                    
                    // MARK: Button to add new event
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .padding(10)
                        .padding(.vertical, 40)
                        .background(BlurView(style: .systemMaterial))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        .padding(.leading, 35)
                        .padding(.trailing, 10)
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
                    
                    // MARK: List with own events
                    ForEach(meEventLineVM.eventArray.indices, id: \.self) { event in
                        HStack {
                            MeEventNView(event: $meEventLineVM.eventArray[event])
                                .rotation3DEffect(
                                    // get new angle, move the min x 30pt more to the right and make the whole angle smaller with the / - 40
                                    Angle(
                                        degrees: Double(geometry.frame(in: .global).minX - 30) / -20),
                                    axis: (x: 0, y: 10, z: 0)
                                )
                                
                                // tap on each of the events does that
                                .onTapGesture {
                                    
                                    // save UserModelObject
                                    tappedEvent = meEventLineVM.eventArray[event]
                                    
                                    // shows the MeMatch
                                    showMeMatchView = true
                                }
                        }
                    }
                }
            }
        }        
        .onAppear {
            self.meEventLineVM.getMeEvents()
        }
    }
}

struct MeEventLineView_Previews: PreviewProvider {
    static var previews: some View {
        MeEventLineView(showCreationView: .constant(false), showMeMatchView: .constant(false), tappedEvent: .constant(stockEvent))
    }
}
