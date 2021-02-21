//
//  MeMatchView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 21.02.21.
//

import SwiftUI
import URLImage

struct MeMatchView: View {
    
    var name: String = "Lisa"
    var age: Date = createSampleDate()
    var pictureURL: URL = stockURL
    
    private var screenWidth: CGFloat? = 340
    
    
    var body: some View {
        ZStack {
            
            URLImage(url: pictureURL) { image in
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
                            Text(name)
                                .font(.title)
                                .foregroundColor(.accentColor)
                            Text(String(dateToAge(date: age)))
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
                        }
                            
//                            Divider()
//                                .frame(height: 40)
                            
                        // MARK: Accept Match - Button
                        ZStack {
                            Image(systemName: "checkmark.circle")
                                    .font(.title)
                                .foregroundColor(.green)
                        }
                        .frame(width: (screenWidth! - 40) * 1/3)
                        .padding(4)
                        .background(Color.green.opacity(0.3))
                        
                        
                        }
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .padding(.bottom, 12)
                        
                        
                        
                }
                .background(BlurView(style: .systemThinMaterial))
                
            }
                
            
        }
        .frame(width: screenWidth, height: 620, alignment: .center)
        .modifier(FrozenWindowModifier())
    }
}

struct MeMatchView_Previews: PreviewProvider {
    static var previews: some View {
        MeMatchView()
    }
}
