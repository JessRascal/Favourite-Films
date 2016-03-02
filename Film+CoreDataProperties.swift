//
//  Film+CoreDataProperties.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 01/03/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Film {

    @NSManaged var image: NSData?
    @NSManaged var title: String?
    @NSManaged var url: String?
    @NSManaged var imdbRating: NSNumber?
    @NSManaged var myRating: NSNumber?
    @NSManaged var imdbDescription: String?
    @NSManaged var myReview: String?

}
