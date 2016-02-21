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
        
    }
    
    @IBAction func loadDetailVC(sender: AnyObject!) {
        let navTitle = "Add a Film"
        performSegueWithIdentifier("goToDetailVCEdit", sender: navTitle)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetailVCEdit" {
            if let detailVC = segue.destinationViewController as? DetailVC {
                self.navigationItem.title = "Cancel"
                detailVC.navTitle.title = "Add a Film"
            }
        }
        
        if segue.identifier == "goToDetailVCRead" {
            if let detailVC = segue.destinationViewController as? DetailVC {
             self.navigationItem.title = "Back"
                detailVC.navTitle.title = "Film Details"
            }
        }
    }
}

