//
//  UrlTextField.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 05/03/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class UrlTextField: CustomTextField {
    private let urlPrefix = "http://"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func addPrefix() {
        // Add the defined prefix to the text field if the field is blank.
        guard let fieldText = self.text where fieldText == "" else {
            return
        }
        self.text = urlPrefix
    }
    
    func removePrefix() {
        // Remove the prefix if no other text has been entered.
        guard let fieldText = self.text where fieldText == urlPrefix else {
            return
        }
        self.text = ""
    }
}