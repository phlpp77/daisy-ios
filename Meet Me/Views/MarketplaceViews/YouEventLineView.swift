//
//  YouEventLineView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.02.21.
//

import SwiftUI
import PromiseKit
import MapKit


struct YouEventLineView: View {
    
    @ObservedObject private var showedEventsModel = ShowedEventsModel()
    @StateObject private var youEventLineVM = YouEventLineViewModel()
    @EnvironmentObject var locationManager: LocationManager
    // data transfer form database
    @State var eventArray: [EventModel] = []
    @State private var loading: Bool = false
    
    @Binding var tappedYouEvent: EventModel
    @Binding var showYouProfileView: Bool
    
    // index which event needs to be removed from the array/scrollview
    @State var eventRemoveIndex: Int = -1
    
    var body: some View {
        ZStack {
            
            // MARK: Dashed rectangle for dragging
            Text("Drag Events down to like")
                .frame(width: 250, height: 25, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(style: StrokeStyle(
                            lineWidth: 2,
                            dash: [10]
                        ))
                        .foregroundColor(Color.green.opacity(0.9))
                )
                .offset(y: 150)
            
            
            // MARK: Horizontal event list
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        
                        // create a view for each event in the array
                        ForEach(eventArray.indices, id: \.self) { eventIndex in
                            GeometryReader { geometry in
                                
                                YouEventNView(events: $eventArray, eventIndex: eventIndex, currentEvent: eventArray[eventIndex])
                                    .rotation3DEffect(
                                        // get new angle, move the min x 30pt more to the right and make the whole angle smaller with the / - 40
                                        Angle(
                                            degrees: Double(geometry.frame(in: .global).minX - 30) / -40),
                                        axis: (x: 0, y: 10, z: 0)
                                    )
                                    
                                    
//                                    .onTapGesture {
//                                        tappedYouEvent = eventArray[eventIndex]
//                                        withAnimation(.easeIn(duration: 0.1)) {
//                                            showYouProfileView = true
//                                        }
//                                        
//                                    }
                            }
                            
                            .frame(width: 250, height: 250)
                            .padding(.bottom, 120)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                        }
                        // needed to update dragged event and array
                        .id(UUID())
                        
                        // button at the end to refresh events
                        Button(action: {
                            //DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                //if eventArray.count == 0 {
                                    firstly {
                                        self.youEventLineVM.getYouEvents(region: locationManager.region, shuffle: false)
                                    }.done { events in
                                        self.eventArray = events
                                        showedEventsModel.events = events
                                        showedEventsModel.save()
                                        print("done")
                                    }.catch { error in
                                        print("DEBUG: error in GetYouEventChain: \(error)")
                                        print("DEBUG: \(error.localizedDescription)")
                                    }
                                //}
                            //}
                        }, label: {
                            Text("REfresh")
                                .font(.largeTitle)
                                .frame(width: 175, height: 175)
                                .modifier(offWhiteShadow(cornerRadius: 14))
                                .padding(30)
                        })
                        
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
            self.eventArray = showedEventsModel.events

        }
        
    }
    
}

struct EventLineView_Previews: PreviewProvider {
    static var previews: some View {
        YouEventLineView(tappedYouEvent: .constant(stockEvent), showYouProfileView: .constant(true))
    }
}
