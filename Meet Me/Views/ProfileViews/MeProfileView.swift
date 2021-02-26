//
//  MeProfileView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 13.02.21.
//

import SwiftUI
import URLImage
import PromiseKit

struct MeProfileView: View {
    
    @ObservedObject private var meProfileVM = MeProfileViewModel()
    
    // changed when not used inside the profile tab
    @State var totalHeight: CGFloat = 480

    var body: some View {
        
        VStack {
            
            // MARK: title
            HStack(spacing: 0.0) {
                Text("That's ")
                Text("ME")
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(.accentColor)
                Text("!")
                    
            }
            .font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .leading)
                
            
            Spacer()
            
            // MARK: profile picture
            URLImage(url: meProfileVM.userPictureURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
//                    .frame(maxWidth: .infinity)
                    
                    .frame(height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.9), Color.gray]), startPoint: .topTrailing, endPoint: .bottomLeading),
                                lineWidth: 15
                            )
                    )
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    .padding(.horizontal, 20)
            }
            
            Spacer()
            
            // MARK: lower/detail part
            HStack {
                
                // First Line with data
                VStack(alignment: .leading) {
                    Text(meProfileVM.userModel.name)
                        .font(.headline)
                    Spacer()
                    
                    HStack {
                        Text("I am")
                        Text(meProfileVM.userModel.gender)
                    }
                    
                }
                
                
                Divider()
                
                // second line with data
                VStack(alignment: .trailing) {
                    HStack {
                        Text(String(dateToAge(date: meProfileVM.userModel.birthdayDate)))
                            .foregroundColor(.accentColor)
                        Text("Years old")
                    }
                    .font(.headline)
                    
                    Spacer()
                    
                    HStack {
                        Text("Show me")
                        Text(meProfileVM.userModel.searchingFor)
                            .foregroundColor(.accentColor)
                        Text("users")
                    }
                }
            }.onAppear {
                
                
                firstly {
                    self.meProfileVM.getUserProfile()
                }.map { userModel in
                    meProfileVM.userModel = userModel
                    meProfileVM.userPictureURL = URL(string: userModel.userPhotos[1]!)!
                }.catch { error in
                    print("DEBUG: error in getUserProfileChain \(error)")
                    print("DEBUG: \(error.localizedDescription)")
                }
            }
            .padding()
            .frame(height: 80)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.black.opacity(0.2), lineWidth: 5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            
            
            
        }
        .padding()
        .frame(width: 340, height: totalHeight, alignment: .center)
        
    }
}


struct MeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MeProfileView()
    }
}




