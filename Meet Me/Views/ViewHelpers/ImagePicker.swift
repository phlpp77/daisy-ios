//
//  ImagePicker.swift
//  Meet Me
//
//  Created by Philipp Hemkemeyer on 27.02.21.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    
    
    @Binding var images: [UIImage]
    @Binding var showPicker: Bool
    
    // MARK: configuration
    
    // config of the filter, which type can be picked inside the picker
    var filter: PHPickerFilter = .images
    // config of the limited, how many items can be picked at once
    var limit: Int = 3
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        var configuration = PHPickerConfiguration()
        configuration.filter = filter
        configuration.selectionLimit = limit
        
        // adding the configuration to the picker
        let picker = PHPickerViewController(configuration: configuration)
        
        // adding the delegate
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // needed for protocol but not in this case
    }
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            // closing the picker
            parent.showPicker.toggle()
            
            // getting the results
            for img in results {
                
                // error handling, if items can be loaded
                if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    
                    img.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        guard let img = image else {
                            print(error!.localizedDescription)
                            return
                        }
                        self.parent.images.append(img as! UIImage)
//                        self.parent.images[0] = img as! UIImage
                    }
                    
                } else {
                }
                
            }
        }
    }
}
