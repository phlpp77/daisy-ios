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
    //let application: UIApplication = UIApplication()
    @State private var eventArray: [EventModel] = [stockEvent, stockEvent]
    @State private var tappedMeEvent: EventModel = stockEvent
    @State private var tappedYouEvent: EventModel = stockEvent
    
    @State private var firstEventCreation: Bool = true
    
    var body: some View {
        ZStack {
            
            VStack {
                
                HeaderView(text1: "Meet ", text2: " Market", highlightText: "ME")
                
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
                        
                        YouEventLineView(tappedYouEvent: $tappedYouEvent, showYouProfileView: $showYouProfileView)
                    }
                    .opacity(showYouProfileView ? 0.1 : 1)
                    .opacity(showCreationView ? 0.1 : 1)
                }
                
            }
            .sheet(isPresented: $showCreationView, content: {
                EventCreationView(presentation: $showCreationView, eventArray: $eventArray)
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
