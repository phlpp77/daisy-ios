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
    @ObservedObject private var firstActions = FirstActions()
    
    @StateObject private var youEventLineVM = YouEventLineViewModel()
    @EnvironmentObject var locationManager: LocationManager
    // data transfer form database
    @State var eventArray: [EventModel] = []
    @State private var loading: Bool = false
    
    @Binding var tappedYouEvent: EventModel
    @Binding var showYouProfileView: Bool
    
    // index which event needs to be removed from the array/scrollview
    @State var eventRemoveIndex: Int = -1
    @GestureState var longPress: Bool = false
    @State var pressDone: Bool = false
    
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
                        .gradientForeground(gradient: secondaryGradient)
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
                        // needed to update dragged event and array
                        .id(UUID())
                        
                        // button at the end to refresh events
                        refreshButton
                            .frame(width: 250, height: 250)
                            .padding(.bottom, 120)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                        
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                Spacer()
            }
            .frame(height: 380)
            
            // loading screen deactivated
            //            LoadingView(showLoadingScreen: $loading)
            
//                boomBar
//                    .opacity(pressDone ? 0 : 0.95)
            
            
            
            
        }
        .frame(height: 380)
        .onAppear {
            //Check if it is the first login
            if firstActions.firstViews["FirstEventShuffle"] == false || firstActions.firstViews["FirstEventShuffle"] == nil {
                //if it is the first Login load events without hitting shuffle button 
                firstly {
                    self.youEventLineVM.getYouEvents(region: locationManager.region, shuffle: true)
                }.done { events in
                    self.eventArray = events
                    showedEventsModel.events = events
                    showedEventsModel.save()
                    self.youEventLineVM.addOneToRefreshCounter()
                    
                    //add FirstventShuffle to Dictionary
                    firstActions.firstViews["FirstEventShuffle"] = true
                    firstActions.save()
                    print("aufgerufen")
                    print("done")
                }.catch { error in
                    print("DEBUG: error in GetYouEventChain: \(error)")
                    print("DEBUG: \(error.localizedDescription)")
                }
            }else {
                self.eventArray = showedEventsModel.events
            }
        }
        
    }
    
    // MARK: Button to get new events
    var refreshButton: some View {
        
        
        VStack {
            Text("Press and hold to")
                .font(.footnote)
            Text("REFRESH")
                .gradientForeground(gradient: secondaryGradient)
                .font(.largeTitle)
                .frame(minWidth: 175, minHeight: 175)
//                .frame(width: longPress ? 200 : 175, height: longPress ? 200 : 175)
                
                
                .gesture(LongPressGesture(minimumDuration: 2)
                            .updating($longPress) { currentState, gestureState, transaction in
                                
                                transaction.animation = Animation.easeInOut(duration: 2.0)
                                gestureState = currentState
                                
                            }
                            .onEnded { value in
                                print("ended")
                                pressDone = true
                                
                                // refresh youEvents
                                firstly {
                                    self.youEventLineVM.getYouEvents(region: locationManager.region, shuffle: true)
                                }.done { events in
                                    self.eventArray = events
                                    showedEventsModel.events = events
                                    showedEventsModel.save()
                                    self.youEventLineVM.addOneToRefreshCounter()
                                    print("done")
                                }.catch { error in
                                    print("DEBUG: error in GetYouEventChain: \(error)")
                                    print("DEBUG: \(error.localizedDescription)")
                                }.finally {
                                    //enter Code to end Animation here
                                    // TODO: End Button animation
                                }
                                
                                
                            })
                .frame(width: 175, height: 175, alignment: .center)
                .modifier(offWhiteShadow(cornerRadius: 14))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .trim(from: longPress ? 0 : 1, to: 1)
                        .stroke(Color.secondary, style: StrokeStyle(lineWidth: longPress ? 30 : 4, lineCap: .round, lineJoin: .round, miterLimit: 0, dash: [longPress ? 800 : 0, 1000], dashPhase: 0))
                )
                .padding(30)
                .frame(width: 250, height: 250, alignment: .center)
            
        }
        
    }
    
    
    // MARK: BoomBar
    var boomBar: some View {
        Image("Beam")
            .resizable()
            .aspectRatio(contentMode: .fill)
//            .frame(maxWidth: pressDone ? .infinity : 0, maxHeight: pressDone ? .infinity : 0)
            .frame(width: 400, height: 350, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .offset(x: pressDone ? 0 : -1500)
            .animation(.easeOut(duration: 1.5))
            .padding(.vertical, 5)
            .onChange(of: pressDone, perform: { value in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                                pressDone = false
                    
                })
            })
    }
    
}

struct EventLineView_Previews: PreviewProvider {
    static var previews: some View {
        YouEventLineView(tappedYouEvent: .constant(stockEvent), showYouProfileView: .constant(true))
    }
}
