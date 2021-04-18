//
//  ReportedView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 17.04.21.
//

import SwiftUI

struct ReportedView: View {
    
    var body: some View {
        VStack {
            VStack {
                Text("DAISY")
                    .gradientForeground(gradient: secondaryGradient)
                Text("You have been banned!")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 32))
            }
            .font(.system(size: 75))
            
            Text("Your behaviour does not match our guidelines so you have been banned.")
                .font(.title2)
                .padding(.bottom, 40)
            
            LoadingView(showLoadingScreen: .constant(true))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundMain"))
        .ignoresSafeArea()
    }
}

struct ReportedView_Previews: PreviewProvider {
    static var previews: some View {
        ReportedView()
    }
}
