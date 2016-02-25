//
//  CustomTextField.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 21/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    let border = CALayer()
    let borderWidth = CGFloat(1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the text field to just have a bottom border.
        border.borderColor = UIColor.appSecondaryColor().CGColor
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        // Set the placeholder text colour.
        self.attributedPlaceholder = NSAttributedString(string: self.attributedPlaceholder!.string, attributes: [NSForegroundColorAttributeName: UIColor.placeholderColor()])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Set the border size and location (within this method to handle orientation changes).
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width:  self.frame.size.width, height: self.frame.size.height)
        
    }
    
}