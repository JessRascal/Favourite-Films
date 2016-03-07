//
//  Film.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 01/03/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import CoreData
import UIKit


class Film: NSManagedObject {

    func setFilmImage(image: UIImage) {
        let data = UIImagePNGRepresentation(image)
        self.image = data
    }
    
    func getFilmImage() -> UIImage {
        let img = UIImage(data: self.image!)!
        return img
    }
    
}
