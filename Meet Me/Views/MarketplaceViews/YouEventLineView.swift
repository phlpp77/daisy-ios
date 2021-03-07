//
//  YouEventLineView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.02.21.
//

import SwiftUI
import PromiseKit

struct YouEventLineView: View {
    
    
    @ObservedObject private var youEventLineVM = YouEventLineViewModel()

    
    //var firestoreManagerEventTest: FirestoreManagerEventTest = FirestoreManagerEventTest()
    
    // data transfer form database
    @State private var eventArray: [EventModelObject] = []
    @State private var loading: Bool = false
    
    @Binding var tappedYouEvent: EventModelObject
    @Binding var showYouProfileView: Bool
    
    @State var eventRemoveIndex: Int = -1
    // index which event needs to be removed from the array/scrollview
    
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
                        ForEach(eventArray.indices, id: \.self) { eventIndex in
                            GeometryReader { geometry in
                                
                                
                                // , eventArray: $youEventLineVM.eventArray
                                YouEventView(eventModelObject: eventArray[eventIndex], eventIndex: eventIndex, dragPossible: true, eventArray: $eventArray)
                                    .rotation3DEffect(
                                        // get new angle, move the min x 30pt more to the right and make the whole angle smaller with the / - 40
                                        Angle(
                                            degrees: Double(geometry.frame(in: .global).minX - 30) / -40),
                                        axis: (x: 0, y: 10, z: 0)
                                    )
                                    
                                    
                                    .onTapGesture {
                                        tappedYouEvent = eventArray[eventIndex]
                                        withAnimation(.easeIn(duration: 0.1)) {
                                            showYouProfileView = true
                                        }
                                        
                                    }
                            }
                            
                            .frame(width: 250, height: 250)
                            .padding(.bottom, 120)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                        }

                        .id(UUID())
                        
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                Spacer()
            }
            .frame(height: 380)
            
            // loading screen deactivated
            //            LoadingView(showLoadingScreen: $loading)
        }
        .frame(height: 380)
        .onAppear {
            loading = true
            firstly {
                self.youEventLineVM.getYouEvents()
            }.done { events in
                self.eventArray = events
                
            }.catch { error in
                print("DEBUG: error in GetYouEventChain: \(error)")
                print("DEBUG: \(error.localizedDescription)")
            }.finally {
                loading = false
            }


            
        }
        
    }
    
}

struct EventLineView_Previews: PreviewProvider {
    static var previews: some View {
        YouEventLineView(tappedYouEvent: .constant(stockEventObject), showYouProfileView: .constant(true))
    }
}
