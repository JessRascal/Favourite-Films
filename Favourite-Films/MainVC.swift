//
//  ViewController.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 20/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
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
    
    // MARK: - Table Functions
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("filmCell") as? FilmCell {
            // CONFIGURE CELL HERE
            return cell
        } else {
            return FilmCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // CHANGE BASED ON DATA SOURCE.
    }
    
    @IBAction func loadDetailVC(sender: AnyObject!) {
        performSegueWithIdentifier("goToDetailVCEdit", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetailVCEdit" {
            if let detailVC = segue.destinationViewController as? DetailVC {
                detailVC.navTitle.title = "Add a Film"
            }
        }
        
        if segue.identifier == "goToDetailVCRead" {
            if let detailVC = segue.destinationViewController as? DetailVC {
                detailVC.navTitle.title = "Film Details"
                detailVC.readOnly = true
            }
        }
    }
}

