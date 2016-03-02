//
//  FilmCell.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 25/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class FilmCell: UITableViewCell {

    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var filmUrl: UIButton!
    @IBOutlet weak var imdbStarImage: UIImageView!
    @IBOutlet weak var myStarImage: UIImageView!
    //@IBOutlet weak var imdbDesc: UILabel!
    //@IBOutlet weak var myReview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.tintColor = UIColor.appSecondaryColor()
    }
    
    func configureCell(film: Film) {
        titleLabel.text = film.title
        imdbStarImage.image = UIImage(named: "Star\(Int(film.imdbRating!))")
        myStarImage.image = UIImage(named: "Star\(Int(film.myRating!))")
        filmImage.image = film.getFilmImage()
    }

}
