//
//  OnboardingSlideView.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 14.03.21.
//

import SwiftUI

struct OnboardingSlideView: View {
    
    @Binding var showSlider: StartPosition
    
    @Binding var index: Int
    var sliderArray: [SliderModel]
    
    var body: some View {
        
        GeometryReader { bounds in
            VStack {
                
                Spacer()
                
                
                ZStack {
                    VStack {
                        
                        Spacer()
                        
                        if sliderArray[index].highlight {
                            Text(sliderArray[index].headerText)
                                .font(.largeTitle)
                                .gradientForeground(gradient: secondaryGradient)
                        } else {
                            Text(sliderArray[index].headerText)
                                .font(.largeTitle)
                        }
                        
                        
                        
                        
                        if sliderArray[index].footerText != "" {
                            Text(sliderArray[index].footerText)
                                .font(.title)
                                .padding(.top, 5)
                        }
                        
                        Image(sliderArray[index].image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        HStack(spacing: 5.0) {
                            ForEach(sliderArray.indices, id: \.self) { sliderIndex in
                                Capsule()
                                    .frame(width: sliderIndex == index ? 24 : 13, height: 13)
                                    .foregroundColor(sliderIndex == index ? Color("BackgroundSecondary") : .gray)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    
                    .frame(width: (bounds.size.width - 48), height: (bounds.size.width - 48) * 1.33 + 40)
                    .modifier(offWhiteShadow(cornerRadius: 26))
                    .padding(.horizontal, 48)
                    
                    iconCircle
                        .offset(x: (bounds.size.width - 48) / 2 - 30, y: -((bounds.size.width - 48) * 1.33) / 2 + 10)
                }
                .onTapGesture {
                    if index < sliderArray.count - 1 {
                        index += 1
                    } else {
                        showSlider = .registerLogin
                    }
                }
                
                
                
                Spacer()
                
                Button(action: {
                    if index < sliderArray.count - 1 {
                        index += 1
                    } else {
                        showSlider = .registerLogin
                    }
                }, label: {
                    button
                })
                .frame(width: (bounds.size.width - 48))
//                .padding(.bottom, bounds.safeAreaInsets.bottom)
                .padding(.bottom, 40)
            }
            .onAppear {
                print(bounds.safeAreaInsets.bottom)
            }
            
            .frame(width: bounds.size.width, height: bounds.size.height)
            .background(
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            )
            
            
            
        }
    }
    
    
    // MARK: -
    var iconCircle: some View {
        
        // MARK: Circle which shows an icon
        ZStack {
            
            // Background Blur
            BlurView(style: .systemUltraThinMaterial)
                .frame(width: 91, height: 91)
                
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
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
            
            // Actual icon
            Image(systemName: sliderArray[index].sfSymbol)
                .font(.system(size: 30))
                .foregroundColor(.accentColor)
        }
    }
    
    
    // MARK: -
    var button: some View {
        
        VStack(spacing: 0.0) {
            Text(sliderArray[index].buttonText)
                .font(.system(size: 30))
                .foregroundColor(.accentColor)
            Capsule()
                .gradientForeground(gradient: secondaryGradient)
                .frame(width: 58, height: 6)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 53)
        .modifier(offWhiteShadow(cornerRadius: 14))
        
        
    }
}

//struct OnboardingSlideView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingSlideView(showSlider: <#Binding<StartPosition>#>, index: <#Binding<Int>#>, sliderArray: <#[SliderModel]#>)
//    }
//}
