//
//  ImagePicker.swift
//  Meet Me
//
//  Created by Lukas Dech on 11.02.21.
//

import Foundation
import SwiftUI



class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isShown: Bool
    @Binding var isDone: Bool
    @Binding var image: Image?
    @Binding var originalImage: UIImage?
    
    init(isShown: Binding<Bool>, isDone: Binding<Bool>, image: Binding<Image?>, originalImage: Binding<UIImage?>) {
        _isShown = isShown
        _isDone = isDone
        _image = image
        _originalImage = originalImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image = Image(uiImage: uiImage)
        isShown = false
        originalImage = uiImage
        isDone = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
    
}

struct ImageOldP: UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var isDone: Bool
    @Binding var image: Image?
    @Binding var originalImage: UIImage?
    var sourceType: SourceType
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImageOldP>) {
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(isShown: $isShown, isDone: $isDone, image: $image, originalImage: $originalImage)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImageOldP>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType == .camera ? .camera : .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
}
