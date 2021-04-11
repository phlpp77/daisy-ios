//
//  MainExploreView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 08.02.21.
//

import SwiftUI

struct MainExploreView: View {
    
    @ObservedObject var firstActions: FirstActions = FirstActions()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    // states for animation
    @State private var showCreationView: Bool = false
    @State private var showMeEventController: Bool = false
    @State private var showYouProfileView: Bool = false
    @State private var showHeaderSheet: Bool = false
    //let application: UIApplication = UIApplication()
    @State private var eventArray: [EventModel] = [stockEvent, stockEvent]
    @State private var tappedMeEvent: EventModel = stockEvent
    @State private var tappedYouEvent: EventModel = stockEvent
    
    @State private var eventLiked: Bool = false
    @State private var eventCreated: Bool = false
    
    @State private var firstEventCreation: Bool = true
    
    var body: some View {
        ZStack {
            
            VStack {
                
                HeaderView(text1: "Meet ", text2: " Market", highlightText: "ME")
                    .onTapGesture {
                        if true {
                            showHeaderSheet = true
                        }
                    }

                
                if !showMeEventController {
                    VStack {
                        
                        Text("Me Events")
                            .font(.subheadline)
                            .bold()
                            .textCase(.uppercase)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 12)
                        
                        MeEventLineView(showCreationView: $showCreationView, showMeMatchView: $showMeEventController, tappedEvent: $tappedMeEvent)
                        
                        Text("You Events")
                            .font(.subheadline)
                            .bold()
                            .textCase(.uppercase)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 12)
                        
                        YouEventLineView(tappedYouEvent: $tappedYouEvent, showYouProfileView: $showYouProfileView, showSuccess: $eventLiked)
                    }
                    .opacity(showYouProfileView ? 0.1 : 1)
                    .opacity(showCreationView ? 0.1 : 1)
                }
                
            }
            .sheet(isPresented: $showCreationView, content: {
                EventCreationView(presentation: $showCreationView, eventArray: $eventArray, eventCreated: $eventCreated)
            })
            .sheet(isPresented: $showHeaderSheet, content: {
                VStack {
                    Spacer()
                    
                    Text("What are you searching here? There is nothing to find.. Create events and meet people!")
                        .italic()
                        .padding()
                    Spacer()
                    Text("#EasterEgg")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            })
            
            // create the setup EventView on top of the rest
            if showCreationView {
                if firstActions.firstViews["FirstEventCreation"] == false || firstActions.firstViews["FirstEventCreation"] == nil {
                    InformationCard(goToNextView: $firstEventCreation, goToLastView: $firstEventCreation, sliderArray: [InformationCardModel(headerText: "Create Event", highlight: true, footerText: "", image: "create-event", sfSymbol: "calendar.badge.plus", buttonText: "OK!", subtext: "Tap on each event aspect to change it directly - create your own unique event!")])
                        .onChange(of: firstEventCreation, perform: { value in
                            // update variable to true that user does not see the info again
                            firstActions.firstViews["FirstEventCreation"] = true
                            // save the status to the phone
                            firstActions.save()
                        })
                } else {
//                    EventCreationView(presentation: $showCreationView, eventArray: $eventArray)
                }
            }
            
            // start the MeMatch process
            if showMeEventController {
                MeEventControllerView(showMeEventControllerView: $showMeEventController, tappedEvent: $tappedMeEvent)
            }
            
            // MARK: Show youProfileView when user taps on a YouEvent
            if showYouProfileView {
                YouProfileNView(showYouProfileView: $showYouProfileView, event: $tappedYouEvent)
            }
            
            // MARK: Show success animations
            if eventLiked {
                CheckView(showCheckView: $eventLiked, text: "Event liked")
            } else if eventCreated {
                CheckView(showCheckView: $eventCreated, text: "Event created")
            }
        }
    }
}

struct MainExploreView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            MainExploreView()
        }
    }
}
