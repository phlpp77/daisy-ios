//
//  YouEventLineView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 10.02.21.
//

import SwiftUI
import PromiseKit

struct YouEventLineView: View {
    
    @StateObject private var youEventLineVM = YouEventLineViewModel()
    
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
            Color.clear
                .frame(width: 250, height: 20, alignment: .center)
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
            let sender = PushNotificationSender()
//            sender.push(message: "funktioniert das jetzt endlich ?", token: "e1LKnA1Uj0YlojFaty_MW9:APA91bFcTaMpiNaVgdelwbfL9bJF6SUt4w0QY8sDZRgCXU2gZ57TOWTBObTuUFxM2qs0LotOOYDfiFlqNgOt-npvW7UiHZ0UQkRvVSFkehNOwqPsue202mTWvcRw-vpsRmYLZyU8PIig")
            sender.sendPushNotification(to: "cQp0TQriaEdygSpCsWam1r:APA91bHMIfB2G83vlWaqB1hrkTdSjxK_DEp8phQ2CCNyiBAaEjeWxMoa1BB7_Q-n3B3aLotXLAbHL7Ju7SmsGzZYwF0o7FglX0jaTnok7AmzbkliKK8ao15RgVbdj00nQKSEeAVLWLyZ", title: "test", body: "funktioniert das jetzt endlich ?")
            
            loading = true
            firstly {
                self.youEventLineVM.getYouEvents()
            }.done { events in
                self.eventArray = events
                print("done")
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
        YouEventLineView(tappedYouEvent: .constant(stockEvent), showYouProfileView: .constant(true))
    }
}
