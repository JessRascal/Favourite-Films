//
//  Constants.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 23/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func appPrimaryColor() -> UIColor { /* Black */
    return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    }
    
    class func appSecondaryColor() -> UIColor { /* Light Grey */
        return UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    }
    
    class func placeholderColor() -> UIColor { /* Darker Grey */
        return UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
    }
    
    class func positiveActionColor() -> UIColor { /* Green */
        return UIColor(red: 1/255, green: 111/255, blue: 48/255, alpha: 1)
    }
    
    class func negativeActionColor() -> UIColor { /* Red */
        return UIColor(red: 111/255, green: 1/255, blue: 1/255, alpha: 1)
    }
    
    class func transparentBlack() -> UIColor { /* Black (75% aplha) */
        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.75)
    }
}

