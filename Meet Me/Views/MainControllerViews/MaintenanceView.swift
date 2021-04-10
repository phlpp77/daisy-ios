//
//  MaintenanceView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 01.04.21.
//

import SwiftUI

struct MaintenanceView: View {
    
    @ObservedObject var developerManager = DeveloperManager()
    
    var body: some View {
        VStack {
            VStack {
                Text("DAISY")
                    .gradientForeground(gradient: secondaryGradient)
                Text("Maintenance break")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 40))
            }
            .font(.system(size: 75))
            
            Text(developerManager.developerOptionsModel.reason == "" ? "We are updating DAISY for the best experience..." : developerManager.developerOptionsModel.reason)
                .font(.title2)
                .padding(.bottom, 40)
            
            LoadingView(showLoadingScreen: .constant(true))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundMain"))
        .ignoresSafeArea()
    }
}

struct MaintenanceView_Previews: PreviewProvider {
    static var previews: some View {
        MaintenanceView()
    }
}
