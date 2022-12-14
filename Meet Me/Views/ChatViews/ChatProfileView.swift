//
//  ChatProfileView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 05.03.21.
//

import SwiftUI
import URLImage
import PromiseKit

struct ChatProfileView: View {
    
    // get user-data
    @Binding var user: UserModel
    
    // animate the view
    @Binding var showChatProfileView: Bool
    
    
    var body: some View {
        
        ZStack {
            
            // MARK: Background (blurred)
            BlurView(style: .systemMaterial)
                .ignoresSafeArea()
                .onTapGesture {
                    showChatProfileView = false
                }
            
            // MARK: Profile shown
            VStack {
                
                // MARK: title
                HStack(spacing: 0.0) {
                    Text("That's ")
                    Text(user.name)
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.accentColor)
                    Text("!")
                    
                }
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                
                Spacer()
                
                // MARK: profile picture
                URLImage(url: URL(string: user.userPhotos[1] ?? stockUrlString)!) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        
                        .frame(width: 300, height: 300, alignment: .center)
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
                        Text(user.name)
                            .font(.headline)
                        Spacer()
                        
                        HStack {
                            Text(user.gender)
                        }
                        
                    }
                    
                    Spacer()
                    Divider()
                    Spacer()
                    
                    // second line with data
                    VStack(alignment: .trailing) {
                        HStack {
                            Text(String(dateToAge(date: user.birthdayDate)))
                                .foregroundColor(.accentColor)
                            Text("Years old")
                        }
                        .font(.headline)
                        
                        Spacer()
                        
                        HStack {
                            Text("Searching for")
                            Text(user.searchingFor)
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
            .frame(width: 340, height: 550, alignment: .center)
            .modifier(FrozenWindowModifier())
            
        }
        
    }
}


struct ChatProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChatProfileView(user: .constant(stockUser), showChatProfileView: .constant(true))
    }
}

