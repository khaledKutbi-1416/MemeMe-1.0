
//  Design.swift
//  MemeMe
//
//  Created by Khaled Kutbi on 11/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.


import UIKit

class imageView: UIImageView{
    
    @IBInspectable var cornerRedius: CGFloat = 0.0{
        
        didSet{
            
            self.backgroundColor = .black
            self.contentMode = .scaleAspectFit
        }
        
        
        
    }
}

class PhotoTextFields: UITextField {
   
    @IBInspectable var cornerRedius: CGFloat = 0.0 {
                          
            didSet{
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            NSAttributedString.Key.strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.strokeWidth: -2,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 37)!,
        ]
                
                self.defaultTextAttributes = memeTextAttributes
                self.textAlignment = .center
                self.backgroundColor = .clear
                self.borderStyle = .none
                self.autocapitalizationType = .allCharacters
                

                self.isHidden = true
                self.isUserInteractionEnabled = false
             
        }
        
    }
    
}

class navigationItam: UINavigationItem{

    @IBInspectable var cornerRedius: CGFloat = 0.0 {
                        
                        didSet{
                            self.title = "MemeMe"

        }
    }
    
}

class navigationMode: UINavigationController {
     @IBInspectable var cornerRedius: CGFloat = 0.0 {
                      
                      didSet{
                        self.navigationBar.barStyle = .black
                        self.toolbar.barTintColor = #colorLiteral(red: 0.2625963986, green: 0.2628829479, blue: 0.2583911121, alpha: 1)
        }
    }
}
class BackGRaoundAppViewColor : UIView{
    @IBInspectable var cornerRedius: CGFloat = 0.0 {
                   
                   didSet{
                    
                    self.backgroundColor = .black
                    
        }
    }
    
}
