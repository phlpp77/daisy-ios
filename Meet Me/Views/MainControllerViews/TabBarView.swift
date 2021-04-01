//
//  TabBarView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 07.03.21.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var startProcessDone: Bool
    
    @State var selectedTab: Tab = .marketplace
    @Namespace var animation
    
    var tabs = [Tab.profile, Tab.marketplace, Tab.chat]
    
    var body: some View {
        GeometryReader { bounds in
            
            VStack(spacing: 0.0) {
                
                    ZStack {
                        
                        // MARK: Tabs
                        switch selectedTab {
                        case .profile:
                            MainSettingsView(startProcessDone: $startProcessDone)
                        case .marketplace:
                            MainExploreView()
                        case .chat:
                            MainChatView()
                        }
                    }
                    
                    // MARK: TabBar
                    HStack(spacing: 0.0) {
                        ForEach(tabs, id: \.self) { tab in
                            Spacer()
                            TabButtonView(selectedTab: $selectedTab, tab: tab, imageName: tab == .profile ? "person.circle" : tab == .marketplace ? "circle.dashed" : tab == .chat ? "paperplane.circle" : "", animation: animation)
                            Spacer()
                        }
                    }
                    .frame(width: bounds.size.width - 48, height: 53, alignment: .center)
                    .background(Color("Offwhite"))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                    )
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 5)
                    .padding(.horizontal, 24)
                    // for older iPhones 15 padding
                    .padding(.bottom, bounds.safeAreaInsets.bottom == 0 ? 15 : 30)
                }
                .ignoresSafeArea(.all, edges: .bottom)
                .background(
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                )
                
            }
        }
    }
    
    struct TabView_Previews: PreviewProvider {
        static var previews: some View {
            TabBarView(startProcessDone: .constant(true))
        }
    }
