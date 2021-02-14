//
//  MeProfileView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 13.02.21.
//

import SwiftUI
import URLImage

struct MeProfileView: View {
    
    private var userId: String?
    private var name: String
    private var birthdayDate: Date
    private var age: Int
    private var gender: String
    private var searchingFor: String
    private var url: String
    private var firestoreFotoManager: FirestoreFotoManager = FirestoreFotoManager()
    @State private var showProfilePhoto: Bool = false
    //URL(string: firestoreFotoManager.photoModel[0].url) ??
    private let testUrl: URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/meetme-1c961.appspot.com/o/UserImages%2F13F2F426-CA65-4E9E-A433-A7B8E866B55B.png?alt=media&token=acbe4056-8993-479d-99f5-bcac9185548b" )!
    
    init(user: UserModel) {
        userId = user.userId
        name = user.name
        birthdayDate = user.birthdayDate
        age = dateToAge(date: birthdayDate)
        gender = user.gender
        searchingFor = user.searchingFor
        url = user.url
    }
    
    var body: some View {
        VStack {
            Text("That's me!")
                .font(.largeTitle)
                .frame(width: 340, alignment: .leading)
            if showProfilePhoto {
                URLImage(url: getProfilePictureURL(url: firestoreFotoManager.photoModel[0].url)) { image
                in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            }
            }
            
//            Image("Philipp")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .overlay(
//                    Circle()
//                        .stroke(Color.white.opacity(0.9), lineWidth: 15)
//                )
//                .clipShape(Circle())
//                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
//                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            
            Spacer()
            
            // lower part
            VStack {
                
                // First Line with data
                HStack {
                    Text(name)
                    
                    Spacer()
                    
                    HStack {
                        Text(String(age))
                            .foregroundColor(.accentColor)
                        Text("Years old")
                    }
                }
                .font(.headline)
                
                Spacer()
                
                // second line with data
                HStack {
                    HStack {
                        Text("I am")
                        Text(gender)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Show me")
                        Text(searchingFor)
                            .foregroundColor(.accentColor)
                        Text("users")
                    }
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
        .onAppear{
            
            firestoreFotoManager.getAllPhotosFromUser(completionHandler: { success in
                if success {
                    // yeah picture
                    showProfilePhoto = firestoreFotoManager.photoModel.count > 0
                    print(firestoreFotoManager.photoModel)
                    print("Erfolg")
                    print(showProfilePhoto)
                    print("\(firestoreFotoManager.photoModel.count) Bei Success")
//                    getProfilePictureURL(url: firestoreFotoManager.photoModel[0].url)
                } else {
                    print("else completion")
                    // ohh, no picture
                }
                
            }
            )
            print("\(firestoreFotoManager.photoModel.count) Unter Appear")
            print(showProfilePhoto)
        }
        .frame(width: 340, height: 450, alignment: .center)
    }
    
    func getProfilePictureURL(url: String) -> URL {
        let url = URL(string: url)
        return url!
        
    }
}



struct MeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MeProfileView(user: testUser)
    }
}




