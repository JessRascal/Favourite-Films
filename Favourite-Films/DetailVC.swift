//
//  AddVC.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 20/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var urlField: CustomTextField!
    @IBOutlet weak var imdbStars: StarRating!
    @IBOutlet weak var myStars: StarRating!
    @IBOutlet weak var imdbDesc: CustomTextView!
    @IBOutlet weak var myDesc: CustomTextView!
    
    var readOnly = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if readOnly == true {
            setToReadOnly()
        }
        
    }
    
    func setToReadOnly() {
        // Disables user interaction on all fields and hides the 'Cancel', and 'Save' buttons.
        self.navigationItem.setLeftBarButtonItem(nil, animated: true)
        self.navigationItem.setRightBarButtonItem(nil, animated: true)
        titleField.userInteractionEnabled = false
        urlField.userInteractionEnabled = false
        imdbStars.userInteractionEnabled = false
        myStars.userInteractionEnabled = false
        imdbDesc.userInteractionEnabled = false
        myDesc.userInteractionEnabled = false
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        // Create an action for when the user selects 'Cancel'.
        
        // Closure
        let backAction = { (action: UIAlertAction) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        let alertController = UIAlertController(title: "Cancel Without Saving?", message: "Do you want to discard your unsaved changes?", preferredStyle: .Alert)
        let continueAction = UIAlertAction(title: "Discard", style: .Destructive, handler: backAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        
        alertController.addAction(continueAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}
