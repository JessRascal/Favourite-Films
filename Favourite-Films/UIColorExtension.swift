//
//  Constants.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 23/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

extension UIColor {
    
    /* Light Grey */
    class func appSecondaryColor() -> UIColor {
        return UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    }
    
    /* Darker Grey */
    class func placeholderColor() -> UIColor {
        return UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
    }
    
    /* Black */
    class func appPrimaryColor() -> UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    }
    
    /* Black (75% aplha) */
    class func transparentBlack() -> UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.75)
    }
}

