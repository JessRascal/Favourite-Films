//
//  DetailVC.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 20/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    // Nav bar buttons not set to 'weak' so they remain in memory for when they need to be re-used.
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var urlField: UrlTextField!
    @IBOutlet weak var imdbDesc: CustomTextView!
    @IBOutlet weak var myReview: CustomTextView!
    @IBOutlet weak var imdbStarView: StarRating!
    @IBOutlet weak var myStarView: StarRating!
    @IBOutlet weak var urlButton: ButtonWithBorder!
    @IBOutlet weak var urlButtonSV: UIStackView!
    @IBOutlet weak var imageButton: FilmImageButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    // MARK: - Properties
    var newRecord: Bool!
    var imagePicker: UIImagePickerController!
    var selectedFilm = Film?()
    let placeholderImage = UIImage(named: "AddImagePlaceholder")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checks if the detailVC is being used for a new record and if not then sets it to read only mode.
        if newRecord == false {
            setToReadOnlyMode()
        }
        
        // Checks for taps on the VC from the user for dismissing the keyboard.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Initially disable the 'Save' button.
        disableSaveButton()
        
        // Set the VC as the text fields/views delegate.
        titleField.delegate = self
        urlField.delegate = self
        imdbDesc.delegate = self
        myReview.delegate = self
        
        // Check if the text fields have changed then performs form validation.
        titleField.addTarget(self, action: "formValidation", forControlEvents: UIControlEvents.EditingChanged)
        urlField.addTarget(self, action: "formValidation", forControlEvents: UIControlEvents.EditingChanged)
        
        // Add and remove the url prefix in the urlField as required.
        urlField.addTarget(urlField, action: "addPrefix", forControlEvents: UIControlEvents.EditingDidBegin)
        urlField.addTarget(urlField, action: "removePrefix", forControlEvents: UIControlEvents.EditingDidEnd)
        
        // Checks the image on the image button has been changed (i.e. no longer the placeholder image).
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "formValidation", name: imageButtonImageChangedKey, object: nil)
        
        // Checks if any of the star buttons have been tapped (via a notification from the 'StarRating' class).
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "formValidation", name: starButtonNotificationKey, object: nil)
        
        // Image picker.
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    // MARK: - Form Validation
    
    // Checks if the text views have changed.
    func textViewDidChange(textView: UITextView) {
        formValidation()
    }
    
    // Validates that all fields for a new film have been populated.
    // Disabling the save button is always called (unless all valid) to cover the scenario of a field being populated then the data being removed.
    func formValidation() {
        // Checks the title field isn't blank.
        guard let title = titleField.text where title != "" else {
            disableSaveButton()
            return
        }
        // Checks the url field isn't blank.
        guard let url = urlField.text where url != "" else {
            disableSaveButton()
            return
        }
        // Checks the url field doesn't only contain the prefix text.
        guard let url2 = urlField.text where url2 != "http://" else {
            disableSaveButton()
            return
        }
        // Checks the IMDb descirption field isn't blank.
        guard let imdbDescIn = imdbDesc.text where imdbDescIn != "" else {
            disableSaveButton()
            return
        }
        // Checks the review field isn't blank.
        guard let myReviewIn = myReview.text where myReviewIn != "" else {
            disableSaveButton()
            return
        }
        // Checks the IMDb rating isn't zero.
        guard let imdbRatingIn = imdbStarView.rating where imdbRatingIn > 0 else {
            disableSaveButton()
            return
        }
        // Checks the my rating isn't zero.
        guard let myRatingIn = myStarView.rating where myRatingIn > 0 else {
            disableSaveButton()
            return
        }
        // Checks the film image isn't still the placeholder image.
        guard let filmImage = imageButton.imageView!.image where filmImage != placeholderImage else {
            disableSaveButton()
            return
        }
        // If all of the above guard statements pass then enable the 'Save' button.
        enableSaveButton()
    }
    
    
    // MARK: - Functions
    
    // Read Only Mode - disables user interaction on everything and populates the views with the passed in film data.
    func setToReadOnlyMode() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "setToEditMode")
        navigationItem.setLeftBarButtonItem(nil, animated: true)
        navigationItem.setRightBarButtonItem(editButton, animated: true)
        setFormInteraction(false)
        
        // Populate the views with the film data.
        let film = selectedFilm!
        imageButton.setImage(film.getFilmImage(), forState: .Normal)
        titleField.text = film.title
        urlField.text = film.url
        imdbStarView.rating = Int(film.imdbRating!)
        myStarView.rating = Int(film.myRating!)
        imdbDesc.text = film.imdbDescription
        myReview.text = film.myReview
        setBackgroundImage(film.getFilmImage())
        disableSaveButton()
    }
    
    // Edit Mode - enables user interation on all the fields.
    func setToEditMode() {
        navigationItem.setLeftBarButtonItem(cancelButton, animated: true)
        navigationItem.setRightBarButtonItem(saveButton, animated: true)
        setFormInteraction(true)
    }
    
    // Sets the form field interaction status (editable true = Add/Edit Mode, editable false = Read Only Mode).
    func setFormInteraction(editable: Bool) {
        titleField.userInteractionEnabled = editable
        urlField.userInteractionEnabled = editable
        imdbStarView.userInteractionEnabled = editable
        myStarView.userInteractionEnabled = editable
        imdbDesc.userInteractionEnabled = editable
        myReview.userInteractionEnabled = editable
        imageButton.userInteractionEnabled = editable
        urlButtonSV.hidden = editable
        urlField.hidden = !editable
    }
    
    // Sets the background image.
    func setBackgroundImage(imageIn: UIImage?) {
        if let image = imageIn {
            bgImage.image = image
            bgImage.hidden = false
            bgView.backgroundColor = UIColor.transparentBlack()
        } else {
            bgImage.hidden = true
            bgView.backgroundColor = UIColor.appPrimaryColor()
        }
    }
    
    // Dismiss the keyboard when the user taps out of the active view.
    func dismissKeyboard() {
        // Causes the view (or one of its embedded text fields/views) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Run when the user selects an image from the image picker.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageButton.setImage(image, forState: .Normal)
        setBackgroundImage(image)
    }
    
    // Disable the 'Save' button if it's not already disabled.
    func disableSaveButton() {
        if saveButton.enabled == true {
            saveButton.enabled = false
        }
    }
    
    // Enable the 'Save' button if it's not already enabled.
    func enableSaveButton() {
        if saveButton.enabled == false {
            saveButton.enabled = true
        }
    }
    
    // MARK: - Actions
    
    // Cancel button function.
    @IBAction func cancelTapped(sender: AnyObject) {
        // Displays an alert when the user selects 'Cancel'.
        
        // Closure for back action.
        let backAction = { (action: UIAlertAction) -> Void in
            if self.newRecord == true {
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                self.setToReadOnlyMode()
            }
        }
        
        let alertController = UIAlertController(title: "Cancel Without Saving?", message: "Do you want to discard your unsaved changes?", preferredStyle: .Alert)
        let continueAction = UIAlertAction(title: "Discard", style: .Destructive, handler: backAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        
        alertController.addAction(continueAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Save button function.
    @IBAction func saveTapped(sender: AnyObject) {
        if let image = imageButton.imageView?.image, title = titleField.text, url = urlField.text, imdbDesc = imdbDesc.text, myReview = myReview.text { // ADD RATINGS????????????
            
            // Create the managedObject constant.
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            
            // Save a new record.
            if newRecord == true {
                let entity = NSEntityDescription.entityForName("Film", inManagedObjectContext: context)!
                let film = Film(entity: entity, insertIntoManagedObjectContext: context) // Create a new Film entity in the managed context (waiting room).
                // Set the film's values.
                film.setFilmImage(image)
                film.title = title
                film.url = url
                film.imdbRating = imdbStarView.rating
                film.myRating = myStarView.rating
                film.imdbDescription = imdbDesc
                film.myReview = myReview
                // Insert the new object in to core data.
                context.insertObject(film)
            } else {
                // Update an existing record.
                let film = selectedFilm!
                // Update the film's details.
                film.setFilmImage(image)
                film.title = title
                film.url = url
                film.imdbRating = imdbStarView.rating
                film.myRating = myStarView.rating
                film.imdbDescription = imdbDesc
                film.myReview = myReview
            }
            // Save the film's new/updated details to persistent data.
            do {
                try context.save()
            } catch {
                let err = error as NSError
                print("The film's details could not be saved. Error: \(err)")
            }
            // Clear the film image cache so it's recreated on returning to the MainVC to reflect any changes.
            GlobalVars.filmImageCache.removeAll()
            // Pop the DetailVC to show the MainVC again.
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // Image button function for selecting a film image.
    @IBAction func imageButtonTapped(sender: UIButton) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // URL button function (only displayed in read-only mode).
    @IBAction func urlButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("goToWebView", sender: selectedFilm)
    }
    
    // Segue preparation for displying the WKWebView.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToWebView" {
            if let webViewVC = segue.destinationViewController as? WebViewVC {
                let film = sender as? Film
                webViewVC.incomingUrl = film!.url
                webViewVC.navBar.title = "imdb.com"
            }
        }
    }
}
