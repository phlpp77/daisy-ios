//
//  OnboardingController.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 14.03.21.
//

import SwiftUI

struct OnboardingController: View {
    
    @Binding var showOnboarding: StartPosition
    
    @State var index: Int = 0
    var sliderArray: [SliderModel] = [SliderModel(), SliderModel(headerText: "Do this with DAISY instead!", highlight: true, image: "walking", sfSymbol: "person.2.fill", buttonText: "OK!"), SliderModel(headerText: "Making meeting", highlight: true, footerText: "easy as going shopping.", image: "shopping", sfSymbol: "cart.fill", buttonText: "OK!"), SliderModel(headerText: "Making meeting", highlight: true, footerText: "normal as walking the dog.", image: "dog", sfSymbol: "hare.fill", buttonText: "OK!"), SliderModel(headerText: "Making meeting", highlight: true, footerText: "safely as chilling at home.", image: "chilling", sfSymbol: "lock.shield.fill", buttonText: "GO!")]
    
    var body: some View {
        
        ZStack {
            switch index {
            case 0:
                OnboardingSlideView(showSlider: $showOnboarding, index: $index, sliderArray: sliderArray)
            case 1:
                OnboardingSlideView(showSlider: $showOnboarding, index: $index, sliderArray: sliderArray)
            case 2:
                OnboardingSlideView(showSlider: $showOnboarding, index: $index, sliderArray: sliderArray)
            
            default:
                OnboardingSlideView(showSlider: $showOnboarding, index: $index, sliderArray: sliderArray)
            }
                
            
        }
    }
}

struct OnboardingController_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingController(showOnboarding: .constant(.onboarding))
    }
}
