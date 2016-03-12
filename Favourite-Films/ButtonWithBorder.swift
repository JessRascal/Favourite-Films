//
//  ButtonWithBorder.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 01/03/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class ButtonWithBorder: UIButton {

    override func awakeFromNib() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.appSecondaryColor().CGColor
    }

}
