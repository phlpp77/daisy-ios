//
//  MeProfileNView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 11.03.21.
//

import SwiftUI

struct MeProfileNView: View {
    
    @State var showDeveloperView: Bool = false
    @EnvironmentObject var meProfileVM: MeProfileViewModel
    
    var body: some View {
        
        VStack {
            
            // Header
            HeaderView()
                .onTapGesture {
                    if meProfileVM.userModel.userStatus == "developer" {
                        showDeveloperView = true
                    }
                }
            
            
            Spacer()
            
            ScrollView {
                VStack(spacing: 12) {
                    Spacer()
                    
                    // First block (look of the user)
                    MeProfileFirstBlockView()
                    
                    // Second block (change the search-settings)
                    MeProfileSecondBlockView()
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
            }
            .offset(y: -20)
            
            
            
        }
        .sheet(isPresented: $showDeveloperView, content: {
            DeveloperView()
        })
        
    }
}

struct MeProfileNView_Previews: PreviewProvider {
    static var previews: some View {
        MeProfileNView()
    }
}
