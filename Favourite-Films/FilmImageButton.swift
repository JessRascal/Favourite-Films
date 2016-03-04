//
//  FilmImageButton.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 24/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

var imageButtonImageChangedKey = "imageButtonImageChangedKey"

class FilmImageButton: UIButton {
    
    //IBInspectables
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func setImage(image: UIImage?, forState state: UIControlState) {
        super.setImage(image, forState: state)
        // Send a notification if the buttons image is changed.
        NSNotificationCenter.defaultCenter().postNotificationName(imageButtonImageChangedKey, object: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }

}
