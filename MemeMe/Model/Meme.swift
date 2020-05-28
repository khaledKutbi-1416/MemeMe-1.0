
//  Meme.swift
//  MemeMe
//
//  Created by Khaled Kutbi on 12/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.


import UIKit

struct  Meme {
   
    var topText: String?
    var bottomText: String?
    var orignalImage: UIImage?
    var memedImage: UIImage?

    init(topText:String,bottomText:String,orignalImage:UIImage,memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.memedImage = memedImage
        
    }
    
}
