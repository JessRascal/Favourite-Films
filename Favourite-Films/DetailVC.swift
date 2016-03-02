//
//  AddVC.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 20/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    @IBOutlet weak var urlButton: ButtonWithBorder!
    @IBOutlet weak var imageButton: FilmImageButton!
    
    //MARK: - Properties
    var readOnly = false
    var imdbRatingGiven = false
    var myRatingGiven = false
    var imagePicker: UIImagePickerController!
    
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
        
        //TODO - NEED TO FIND OUT WHICH SET OF STARS (UIVIEW) THE NOTIFICATION CAME FROM.
        // Checks if if any of the star buttons have been tapped (via a notification from the 'StarRating' class.
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateStarRating:", name: starButtonNotificationKey, object: nil)
        
        // Image picker.
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    // Calls this function when a tap is recognized.
    func dismissKeyboard() {
        // Causes the view (or one of its embedded text fields/views) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Disables user interaction on all fields, hides the 'Cancel', and 'Save' buttons, hides the URL field, and displays the URL button.
    func setToReadOnly() {
        self.navigationItem.setLeftBarButtonItem(nil, animated: true)
        self.navigationItem.setRightBarButtonItem(nil, animated: true)
        titleField.userInteractionEnabled = false
        urlField.userInteractionEnabled = false
        urlField.hidden = true
        urlButton.hidden = false
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
        
        //TODO - NEED TO FIND OUT WHICH SET OF STARS (UIVIEW) THE NOTIFICATION CAME FROM FOR THE FORM VALIDATION.
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
    
    //TODO - NEED TO FIND OUT WHICH SET OF STARS (UIVIEW) THE NOTIFICATION CAME FROM FOR THE FORM VALIDATION.
    // Update the star ratings when one is changed.
    //    func updateStarRating(starRatingButton: AnyObject) {
    //        if starRatingButton.isDescendantOfView(self.imdbStarView) {
    //            imdbRatingGiven = true
    //            print("IMDb star rating given.")
    //        }
    //    }

    // MARK: - Actions
    
    @IBAction func cancelTapped(sender: AnyObject) {
        // Perform an action for when the user selects 'Cancel'.
        
        // Closure for back action.
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
    
    @IBAction func saveTapped(sender: AnyObject) {
        if let image = imageButton.imageView?.image, title = titleField.text, let url = urlField.text,/* let imdbRating = imdbRating, let myRating = myRating, */let imdbDesc = imdbDesc.text, let myReview = myReview.text {
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Film", inManagedObjectContext: context)! // Create a new Film class.
            let film = Film(entity: entity, insertIntoManagedObjectContext: context)
            film.setFilmImage(image)
            film.title = title
            film.url = url
            film.imdbRating = 1 // TODO - Capture star rating.
            film.myRating = 1 // TODO - Capture star rating.
            film.imdbDescription = imdbDesc
            film.myReview = myReview
            
            context.insertObject(film)
            do {
                try context.save() // Save the film to the actual database (persisted store).
            } catch {
                print("Could not save film")
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func imageButtonTapped(sender: UIButton) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func urlButtonTapped(sender: AnyObject) {
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageButton.setImage(image, forState: .Normal)
    }
    
    
}
