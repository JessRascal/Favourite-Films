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
    
    override func awakeFromNib() {
        
        let appGrey = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        //let placeholderGrey = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        let placeholderGrey = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        
        // Set the text field to just have a bottom border.
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = appGrey.CGColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height) // ORIGINAL LINE
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width:  self.bounds.size.width, height: self.frame.size.height)
        
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        // Set the placeholder text colour.
        self.attributedPlaceholder = NSAttributedString(string: self.attributedPlaceholder!.string, attributes: [NSForegroundColorAttributeName: placeholderGrey])
    }
    
}