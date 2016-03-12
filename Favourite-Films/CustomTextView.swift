//
//  CustomTextView.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 23/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Set the text colour.
        self.textColor = UIColor.appSecondaryColor()
        textAlignment = NSTextAlignment.Justified
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.appSecondaryColor().CGColor
    }

}
