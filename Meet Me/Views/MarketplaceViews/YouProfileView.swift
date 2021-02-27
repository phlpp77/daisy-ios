//
//  MeProfileView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI
import URLImage
import PromiseKit

struct YouProfileView: View {
    
    // TODO: @budni insert youProfileVM here and rename the vars inside the View
    @ObservedObject private var meProfileVM = MeProfileViewModel()
    
    // animate the view
    @Binding var showYouProfileView: Bool
    @Binding var tappedYouEvent: EventModelObject

    var body: some View {
        
        ZStack {
            
            // MARK: Background (blurred)
            BlurView(style: .systemMaterial)
                .ignoresSafeArea()
                .onTapGesture {
                    showYouProfileView = false
                }
            
            // MARK: Profile shown
        VStack {
            
            // MARK: title
            HStack(spacing: 0.0) {
                Text("That's ")
                Text(meProfileVM.userModel.name)
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(.accentColor)
                Text("!")
                    
            }
            .font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
                
            
            Spacer()
            
            // MARK: profile picture
            URLImage(url: meProfileVM.userPictureURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)

                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
                        Text(meProfileVM.userModel.gender)
                    }
                    
                }
                
                Spacer()
                Divider()
                Spacer()
                
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
                        Text("Searching for")
                        Text(meProfileVM.userModel.searchingFor)
                            .foregroundColor(.accentColor)
                        Text("users")
                    }
                }
            }
            .padding()
            .background(Color("BackgroundSecondary").opacity(0.1))
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.black.opacity(0.2), lineWidth: 5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .padding(.horizontal)
            
            
            
        }
        .padding()
        .frame(width: 340, height: 620, alignment: .center)
        .modifier(FrozenWindowModifier())
        // MARK: Get data from database
        .onAppear {
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
        
        }
        
    }
}


struct YouProfileView_Previews: PreviewProvider {
    static var previews: some View {
        YouProfileView(showYouProfileView: .constant(false), tappedYouEvent: .constant(stockEventObject))
    }
}

