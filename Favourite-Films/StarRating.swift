//
//  StarRating.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 22/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

let starButtonNotificationKey = "starButtonNotificationKey"

class StarRating: UIView {
    
    // MARK: - Properties
    var rating: Int? {
        didSet {
            setNeedsLayout()
        }
    }
    var starButtons = [UIButton]()
    var buttonSpacing = 5
    let numberOfStars = 10
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "StarImageFull")
        let emptyStarImage = UIImage(named: "StarImageEmpty")
        
        for _ in 0..<numberOfStars {
            // Create the buttons.
            let button = UIButton()
            
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.imageView?.contentMode = .ScaleToFill
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: "starButtonTapped:", forControlEvents: .TouchDown)
            
            starButtons += [button]
            addSubview(button)
        }
    }
    
    //MARK: - Functions
    override func layoutSubviews() {
        let buttonSize: Int
        
        // Restrict the button size to be a maximum of 52 (the UIView size for the iPad layout).
        if (Int(self.frame.size.width) / numberOfStars) - buttonSpacing < 52 {
            buttonSize = (Int(self.frame.size.width) / numberOfStars) - buttonSpacing
            // Set the size of the UIView to match the height of the buttons.
            self.frame.size.height = CGFloat(buttonSize)
        } else {
            buttonSize = 52
            // Adjust spacing so the buttons span the width of the UIView (don't count the last button as there won't be a space at the end).
            buttonSpacing = (((Int(self.frame.width)) - (numberOfStars * buttonSize)) / (numberOfStars - 1))
        }
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in starButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + buttonSpacing))
            button.frame = buttonFrame
        }
        // Reset the button spacing back to the default for orientation change.
        buttonSpacing = 5
        updateButtonSelectedStates()
    }
    
    // MARK: - Button Action
    func starButtonTapped(button: UIButton) {
        rating = starButtons.indexOf(button)!+1
        // Post a notification when the rating is updated (used for form validation in DetailVC).
        NSNotificationCenter.defaultCenter().postNotificationName(starButtonNotificationKey, object: self)
        updateButtonSelectedStates()
    }
    
    func updateButtonSelectedStates() {
        for (index, button) in starButtons.enumerate() {
            button.selected = index < rating
        }
    }

}
