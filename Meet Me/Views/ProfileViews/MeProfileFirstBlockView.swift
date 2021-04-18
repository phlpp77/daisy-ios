//
//  MeProfileFirstBlockView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 11.03.21.
//

import SwiftUI
import URLImage

struct MeProfileFirstBlockView: View {
    
    @EnvironmentObject var meProfileVM: MeProfileViewModel
    
    var body: some View {
        VStack {
            
            // MARK: Title of the first block
            HStack(spacing: 0.0) {
                Text("The way ")
                Text("ME")
                    .font(.system(.title2, design: .rounded))
                    .foregroundColor(.accentColor)
                Text(" look")
            }
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: Information block with pictures, age and gender
            HStack {
                // left column
                VStack {
                    PictureCircle(userPhotos: $meProfileVM.userModel.userPhotos, tag: 0, isProfilePicture: true)
                    Spacer()
                    PictureCircle(userPhotos: $meProfileVM.userModel.userPhotos, tag: 2, isProfilePicture: false)
                }
                // right column
                VStack {
                    TextCircle(textContent: String(dateToAge(date: meProfileVM.userModel.birthdayDate)), textSize: 20)
                    PictureCircle(userPhotos: $meProfileVM.userModel.userPhotos, tag: 1, isProfilePicture: false)
                    TextCircle(textContent: meProfileVM.userModel.gender, textSize: 14)
                }
            }
            .padding()
            
        }
        .padding()
        .frame(width: 327, height: 327)
        .background(
            Image("ME-look-background")
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .modifier(offWhiteShadow(cornerRadius: 14))
        .onAppear {

        }
    }
}

struct MeProfileFirstBlockView_Previews: PreviewProvider {
    static var previews: some View {
        MeProfileFirstBlockView()
    }
}


// MARK: - View which is used to replicate the user photos
struct PictureCircle: View {
    
    @EnvironmentObject var meProfileVM: MeProfileViewModel
    @Binding var userPhotos: [Int: String]
    
    @State var showImageHandler: Bool = false
    @State var croppedImage: UIImage?
    
    var tag: Int
    var isProfilePicture: Bool
    
    var body: some View {
        
        // MARK: If the users taps on a pictureCircle
        Menu {
            Button(action: {
//                changePicture(pictureIndex: tag)
                showImageHandler = true
            }, label: {
                Label("Change picture", systemImage: "pencil.circle")
            })
            Button(action: {
                deletePicture(pictureIndex: tag)
            }, label: {
                Label("Delete picture", systemImage: "minus.circle")
            })
        } label: {
            ZStack {
                // MARK: Background Blur
                BlurView(style: .systemUltraThinMaterial)
                    .frame(width: 109, height: 109)
                    
                    // Stroke to get glass effect
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                                        .init(color: Color(#colorLiteral(red: 0.7791666388511658, green: 0.7791666388511658, blue: 0.7791666388511658, alpha: 0.949999988079071)), location: 0),
                                                        .init(color: Color(#colorLiteral(red: 0.7250000238418579, green: 0.7250000238418579, blue: 0.7250000238418579, alpha: 0)), location: 1)]),
                                    startPoint: UnitPoint(x: 0.9016393067273221, y: 0.10416647788375455),
                                    endPoint: UnitPoint(x: 0.035519096038869824, y: 0.85416653880629)),
                                lineWidth: 0.5
                            )
                    )
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.25), radius: 11, x: 0, y: 4)
                
                // MARK: Extra blueish circle when is used as profile picture
                if isProfilePicture {
                    Circle()
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                                    .init(color: Color(#colorLiteral(red: 0.9490196108818054, green: 0.9490196108818054, blue: 0.9490196108818054, alpha: 1)), location: 0),
                                                    .init(color: Color(#colorLiteral(red: 0.0313725508749485, green: 0.45490196347236633, blue: 0.5490196347236633, alpha: 1)), location: 0.53125)]),
                                startPoint: UnitPoint(x: 1, y: 0),
                                endPoint: UnitPoint(x: 1.7763568394002505e-15, y: 1.0000000596046466)),
                            lineWidth: 5
                        )
                        .frame(width: 109, height: 109)
                }
                
                // MARK: Actual Image
                if userPhotos[tag] != nil {
                    URLImage(url: URL(string: userPhotos[tag]!)!) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 91, height: 91)
                            .clipShape(Circle())
                    }
                } else {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .frame(width: 91, height: 91)
                        .clipShape(Circle())
                }
            }
            .sheet(isPresented: $showImageHandler, content: {
               ImageHandler(croppedImage: $croppedImage, showView: $showImageHandler)
            })
            .onChange(of: croppedImage, perform: { value in
                meProfileVM.addPhotoInPosition(image: croppedImage ?? UIImage(named: "FemaleStockImage")!, position: tag)
            })
            
            
        }
    }
    
    
    // Function to delete the picture
    func deletePicture(pictureIndex: Int) {
        meProfileVM.deletePhoto(position: pictureIndex)
    }
}

// MARK: - View which is used to replicate the user texts (age and gender)
struct TextCircle: View {
    
    var textContent: String
    var textSize: CGFloat
    
    var body: some View {
        
        ZStack {
            // MARK: Background Blur
            BlurView(style: .systemUltraThinMaterial)
                .frame(width: 56, height: 56)
                
                // Stroke to get glass effect
                .overlay(
                    Circle()
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                                    .init(color: Color(#colorLiteral(red: 0.7791666388511658, green: 0.7791666388511658, blue: 0.7791666388511658, alpha: 0.949999988079071)), location: 0),
                                                    .init(color: Color(#colorLiteral(red: 0.7250000238418579, green: 0.7250000238418579, blue: 0.7250000238418579, alpha: 0)), location: 1)]),
                                startPoint: UnitPoint(x: 0.9016393067273221, y: 0.10416647788375455),
                                endPoint: UnitPoint(x: 0.035519096038869824, y: 0.85416653880629)),
                            lineWidth: 0.5
                        )
                )
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.25), radius: 11, x: 0, y: 4)
            
            // MARK: Actual text
            Text(textContent)
                .foregroundColor(.accentColor)
                .font(.system(size: textSize))
            
        }
    }
}
