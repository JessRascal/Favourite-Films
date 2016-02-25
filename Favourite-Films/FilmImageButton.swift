//
//  FilmImageButton.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 24/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class FilmImageButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }

}
