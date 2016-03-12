//
//  IMDbButton.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 09/03/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class IMDbButton: UIButton {
    
    let imageNormal = UIImage(named: "ViewOnIMDbLogo")
    let imageHighlighted = UIImage(named: "ViewOnIMDbLogoOpposite")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setBackgroundImage(imageNormal, forState: .Normal)
//        self.setBackgroundImage(imageHighlighted, forState: .Selected)
//        self.setBackgroundImage(imageHighlighted, forState: .Highlighted)
//        self.setBackgroundImage(imageHighlighted, forState: [.Selected, .Highlighted])
    }
}
