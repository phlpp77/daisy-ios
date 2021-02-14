//
//  PhotoModelObject .swift
//  Meet Me
//
//  Created by Lukas Dech on 14.02.21.
//

import Foundation

struct PhotoModelObject {
    
    let photoModel: PhotoModel
    
    var id: String {
        photoModel.id ?? ""
    }
    
    var url: String {
        photoModel.url
    }
    
}

