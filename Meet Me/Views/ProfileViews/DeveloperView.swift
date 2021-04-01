//
//  DeveloperView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.03.21.
//

import SwiftUI

struct DeveloperView: View {
    @ObservedObject var developerVM: DeveloperViewModel = DeveloperViewModel()
    
    
    var body: some View {
        VStack {
            Text("Developer Controls")
                .font(.title)
                .gradientForeground(gradient: secondaryGradient)
                .padding(.top, 10)
            
            Spacer()
            
            VStack(spacing: 20.0) {
                Button(action: {
                    // paste code to work with here
                    developerVM.setShuffelCouterToZeroAllUsers()
                }, label: {
                    // label text
                    Text("Set RefreshCounter to 0")
                })
                
                Button(action: {
                    // paste code to work with here
                    developerVM.deleteAllOldEvents()
                    
                }, label: {
                    // label text
                    Text("DeleteEveryEventOlderThanYesterday")
                })
                
                Button(action: {
                    // paste code to work with here
                    developerVM.setMaintenanceModeToFalse()
                }, label: {
                    // label text
                    Text("setMaintenanceModeToFalse")
                })
                
                Button(action: {
                    developerVM.setMaintenanceModeToTrue()
                    
                }, label: {
                    // label text
                    Text("setMaintenanceModeToTrue")
                })
                
                Button(action: {
                    // paste code to work with here
                    
                }, label: {
                    // label text
                    Text("Button")
                })
            }
            .padding(30)
            .background(Color.black.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            
            
            
            Spacer()
        }
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView()
    }
}
