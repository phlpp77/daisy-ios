//
//  PhotoCaptureView.swift
//  Meet Me
//
//  Created by Lukas Dech on 11.02.21.
//

import Foundation
import SwiftUI

struct PhotoCaptureView: View {
    
    @Binding var showImagePicker: Bool
    @Binding var imagePickerDone: Bool
    @Binding var image: Image?
    @Binding var originalImage: UIImage?
    var sourceType: SourceType
    
    var body: some View {
        ImageOldP(isShown: $showImagePicker, isDone: $imagePickerDone, image: $image, originalImage: $originalImage, sourceType: sourceType)
            .ignoresSafeArea()
           
    }
}

#if DEBUG
struct PhotoCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCaptureView(showImagePicker: .constant(false), imagePickerDone: .constant(false), image: .constant(Image("")), originalImage: .constant(UIImage()), sourceType: .photoLibrary)
    }
}
#endif
