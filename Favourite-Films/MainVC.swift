//
//  ViewController.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 20/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title of the Nav Bar to be the App Logo.
        let appLogo = UIImage(named: "FavouriteFilmsLogo")
        let imageView = UIImageView(image: appLogo)
        imageView.contentMode = .ScaleAspectFit
        imageView.bounds.size.height = 30
        navigationItem.titleView = imageView
        navigationItem.titleView!.contentMode = .ScaleAspectFit
        // Blank button added to the left of the Nav Bar to keep the logo centred (a bit hacky).
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        navigationItem.leftBarButtonItem?.enabled = false
        
        // Set the text of the default 'Back' button (no text, just the arrow).
        navigationItem.title = ""
    }
    
    @IBAction func loadDetailVC(sender: AnyObject!) {
        let navTitle = "Add a Film"
        performSegueWithIdentifier("goToDetailVCEdit", sender: navTitle)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetailVCEdit" {
            if let detailVC = segue.destinationViewController as? DetailVC {
                if let navTitle = sender as? String {
                    detailVC.navTitle.title = navTitle
                }
            }
        }
        
        if segue.identifier == "goToDetailVCRead" {
            if let detailVC = segue.destinationViewController as? DetailVC {
                if let navTitle = sender as? String {
                   detailVC.navTitle.title = navTitle
                }
            }
        }
    }
}

