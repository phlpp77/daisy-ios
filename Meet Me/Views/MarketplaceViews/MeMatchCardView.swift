//
//  MeMatchView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 21.02.21.
//

import SwiftUI
import URLImage

struct MeMatchCardView: View {
    
    // binding vars
    @Binding var userChosen: Bool
    @Binding var users: [UserModelObject]
    @Binding var showMeMatchMainView: Bool
    var user: UserModelObject
    var userNumber: Int
    
    init(userChosen: Binding<Bool>, users: Binding<[UserModelObject]>, user: UserModelObject, userNumber: Int, showMeMatchMainView: Binding<Bool>) {
        self._userChosen = userChosen
        self._users = users
        self.user = user
        self.userNumber = userNumber
        self._showMeMatchMainView = showMeMatchMainView
    }
    
    // internal vars
    var screenWidth: CGFloat? = 340
    
    @State var translation: CGSize = .zero
    @State var degrees: Double = 0
    
    @State var userDenied: Bool = false
    @State var userAccepted: Bool = false
    
    var body: some View {
        
        let dragGesture = DragGesture()
            .onChanged{ (value) in
                translation = value.translation
            }
            .onChanged { (value) in
                
                // state is change to 2 if the drag is to the right and -2 if to the left
                if value.translation.width > 0 {
                    degrees = 2
                    if value.translation.width > 80 {
                        print("user accepted swiped")
                        
                        userAccepted = true
                        
                        userChosen = true
                        
                        showMeMatchMainView = false
                    }
                } else {
                    degrees = -2
                    if value.translation.width < -80 {
                        print("user denied swiped")
                        
                        userDenied = true
                        
                        
//                        self.users.remove(at: userNumber)
                    }
                }
            }
        
        ZStack {
            
            URLImage(url: URL(string: user.url) ?? stockURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenWidth, height: 620, alignment: .center)
            }
            
            
             
            VStack {
                
                // push all details down to show more of the picture
                Spacer()
                
                // MARK: Text Content
                VStack {
                        
                    // MARK: Profile information
                    HStack {
                            Text(user.name)
                                .font(.title)
                                .foregroundColor(.accentColor)
                            Text(String(dateToAge(date: user.birthdayDate)))
                                .font(.body)
                        }
                    .padding(.top, 5)
                    .padding(.bottom, -5)
                    .padding(.horizontal, 12)
                    .frame(width: screenWidth, alignment: .leading)
                        
                        Divider()
                        
                    // MARK: - Button area
                    HStack {
                        
                        // MARK: Deny Match - Button
                        ZStack {
                            Image(systemName: "xmark.circle")
                                    .font(.title)
                                .foregroundColor(.red)
                                
                        }
                        .frame(width: ((screenWidth! - 40) * 2/3))
                        .padding(4)
                        .background(Color.red.opacity(0.3))
                        .onTapGesture {
                            // update database - user not
                            print("user denied tapped")
                            userDenied = true
                            
                            self.users.remove(at: userNumber)
                        }
                    
                            
                        // MARK: Accept Match - Button
                        ZStack {
                            Image(systemName: "checkmark.circle")
                                    .font(.title)
                                .foregroundColor(.green)
                        }
                        .frame(width: (screenWidth! - 40) * 1/3)
                        .padding(4)
                        .background(Color.green.opacity(0.3))
                        .onTapGesture {
                            // user was taken
                            print("user accepted tapped")
                            userAccepted = true
                            
                            userChosen = true
                            
                            showMeMatchMainView = false
                        }
                        
                        
                        }
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .padding(.bottom, 12)
                        
                        
                        
                }
                .background(BlurView(style: .systemThinMaterial))
                
            }
                
            
        }
        .frame(width: screenWidth, height: 620, alignment: .center)
        .modifier(FrozenWindowModifier())
        .offset(x: userDenied ? -400 : 0)
        .offset(x: userAccepted ? 400 : 0)
        .offset(x: translation.width, y: 0)
        .rotationEffect(.degrees(degrees))
        .gesture(dragGesture)
        .animation(.interactiveSpring())
    }
    
}

struct MeMatchCardView_Previews: PreviewProvider {
    static var previews: some View {
        MeMatchCardView(userChosen: .constant(false), users: .constant([stockUserObject, stockUserObject]), user: stockUserObject, userNumber: 1, showMeMatchMainView: .constant(false))
    }
}
