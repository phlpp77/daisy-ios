//
//  MaintenanceView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 01.04.21.
//

import SwiftUI

struct MaintenanceView: View {
    var body: some View {
        VStack {
            VStack {
                Text("DAISY")
                Text("Maintenance break")
            }
            .font(.system(size: 75))
            .gradientForeground(gradient: secondaryGradient)
            Text("We are updating DAISY for the best experience...")
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
