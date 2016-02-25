//
//  AddVC.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 20/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var urlField: CustomTextField!
    @IBOutlet weak var imdbStars: StarRating!
    @IBOutlet weak var myStars: StarRating!
    @IBOutlet weak var imdbDesc: CustomTextView!
    @IBOutlet weak var myReview: CustomTextView!
    @IBOutlet weak var imdbStarView: StarRating!
    @IBOutlet weak var myStarView: StarRating!
    
    //MARK: - Properties
    var readOnly = false
    var imdbRatingGiven = false
    var myRatingGiven = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checks if the views should be read only.
        if readOnly == true {
            setToReadOnly()
        }
        
        // Checks for taps on the VC from the user.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Initially disable the 'Save' button.
        disableSaveButton()
        
        // Set the VC as the text fields/views delegate.
        titleField.delegate = self
        urlField.delegate = self
        imdbDesc.delegate = self
        myReview.delegate = self
        
        // Checks if the text fields have changed.
        titleField.addTarget(self, action: "formValidation", forControlEvents: UIControlEvents.EditingChanged)
        urlField.addTarget(self, action: "formValidation", forControlEvents: UIControlEvents.EditingChanged)
        
        //DISABLED - UNABLE TO FIND OUT WHICH SET OF STARS (UIVIEW) THE NOTIFICATION CAME FROM.
        // Checks if if any of the star buttons have been tapped (via a notification from the 'StarRating' class.
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateStarRating:", name: starButtonNotificationKey, object: nil)
    }
    
    // Calls this function when a tap is recognized.
    func dismissKeyboard() {
        // Causes the view (or one of its embedded text fields/views) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Disables user interaction on all fields and hides the 'Cancel', and 'Save' buttons.
    func setToReadOnly() {
        self.navigationItem.setLeftBarButtonItem(nil, animated: true)
        self.navigationItem.setRightBarButtonItem(nil, animated: true)
        titleField.userInteractionEnabled = false
        urlField.userInteractionEnabled = false
        imdbStars.userInteractionEnabled = false
        myStars.userInteractionEnabled = false
        imdbDesc.userInteractionEnabled = false
        myReview.userInteractionEnabled = false
    }
    
    //MARK: - Form Validation
    
    // Checks if the text views have changed.
    func textViewDidChange(textView: UITextView) {
        formValidation()
    }
    
    // Validates the entries in the formn fields/views.
    func formValidation() {
        guard let title = titleField.text where title != "" else {
//            print("The title field has not been populated.")
            disableSaveButton()
            return
        }
        guard let url = urlField.text where url != "" else {
//            print("The URL field has not been populated.")
            disableSaveButton()
            return
        }
        guard let imdbDescIn = imdbDesc.text where imdbDescIn != "" else {
//            print("The description view has not been populated.")
            disableSaveButton()
            return
        }
        guard let myReviewIn = myReview.text where myReviewIn != "" else {
//            print("The review field has not been populated.")
            disableSaveButton()
            return
        }
        //DISABLED - UNABLE TO FIND OUT WHICH SET OF STARS (UIVIEW) THE NOTIFICATION CAME FROM.
//        if self.imdbRatingGiven != false && myRatingGiven != false {
//            saveButton.enabled = true
//            //        saveButton.tintColor = UIColor.positiveActionColor()
//        } else {
//            print("The IMDb and/or 'My' star rating hasn't been set.")
//            disableSaveButton()
//        }
        saveButton.enabled = true

    }
    
    func disableSaveButton() {
        if saveButton.enabled == true {
            saveButton.enabled = false
        }
    }

    // MARK: - Actions
    
    //DISABLED - UNABLE TO FIND OUT WHICH SET OF STARS (UIVIEW) THE NOTIFICATION CAME FROM.
    // Update the star ratings when one is changed.
//    func updateStarRating(starRatingButton: AnyObject) {
//        if starRatingButton.isDescendantOfView(self.imdbStarView) {
//            imdbRatingGiven = true
//            print("IMDb star rating given.")
//        }
//    }
    
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
    
    @IBAction func imageButtonTapped(sender: AnyObject) {
        print("Image Tapped")
    }
    
    
}
