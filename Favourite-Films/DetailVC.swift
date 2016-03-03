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
    @IBOutlet weak var imdbDesc: CustomTextView!
    @IBOutlet weak var myReview: CustomTextView!
    @IBOutlet weak var imdbStarView: StarRating!
    @IBOutlet weak var myStarView: StarRating!
    @IBOutlet weak var urlButton: ButtonWithBorder!
    @IBOutlet weak var imageButton: FilmImageButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    // MARK: - Properties
    var readOnly = false
    var imagePicker: UIImagePickerController!
    var selectedFilm = Film?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checks if the views should be read only and if true then runs the read only function.
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
        guard let imdbRatingIn = imdbStarView.rating where imdbRatingIn > 0 else {
            disableSaveButton()
            return
        }
        guard let myRatingIn = myStarView.rating where myRatingIn > 0 else {
            disableSaveButton()
            return
        }
        // If all of the above guard statements pass then...
        saveButton.enabled = true
    }
    
    
    // MARK: - Functions
    
    // Calls this function when a tap is recognized.
    func dismissKeyboard() {
        // Causes the view (or one of its embedded text fields/views) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Read Only Mode - disables user interaction on everything and populate the views with the passed in film data.
    func setToReadOnly() {
        self.navigationItem.setLeftBarButtonItem(nil, animated: true)
        self.navigationItem.setRightBarButtonItem(nil, animated: true)
        titleField.userInteractionEnabled = false
        urlField.userInteractionEnabled = false
        urlField.hidden = true
        urlButton.hidden = false
        imdbStarView.userInteractionEnabled = false
        myStarView.userInteractionEnabled = false
        imdbDesc.userInteractionEnabled = false
        myReview.userInteractionEnabled = false
        imageButton.userInteractionEnabled = false
        
        let film = selectedFilm!
        imageButton.setImage(film.getFilmImage(), forState: .Normal)
        titleField.text = film.title
        imdbStarView.rating = Int(film.imdbRating!)
        myStarView.rating = Int(film.myRating!)
        imdbDesc.text = film.imdbDescription
        myReview.text = film.myReview
        setBackgroundImage(film.getFilmImage())
    }
    
    // Disable the 'Save' button if it's not already disabled.
    func disableSaveButton() {
        if saveButton.enabled == true {
            saveButton.enabled = false
        }
    }
    
    // Set the background image if there's one to diaplay.
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
    
    // Run when the user selects an image from the image picker.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageButton.setImage(image, forState: .Normal)
        setBackgroundImage(image)
    }
    
    // MARK: - Actions
    
    // Cancel button function.
    @IBAction func cancelTapped(sender: AnyObject) {
        // Dispolay an aleert when the user selects 'Cancel'.
        
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
    
    // Save button function.
    @IBAction func saveTapped(sender: AnyObject) {
        if let image = imageButton.imageView?.image, title = titleField.text, url = urlField.text, imdbDesc = imdbDesc.text, myReview = myReview.text {
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Film", inManagedObjectContext: context)! // Create a new Film class in the managed context (waiting room).
            let film = Film(entity: entity, insertIntoManagedObjectContext: context)
            film.setFilmImage(image)
            film.title = title
            film.url = url
            film.imdbRating = imdbStarView.rating
            film.myRating = myStarView.rating
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
    
    // Image button function for selecting a film image.
    @IBAction func imageButtonTapped(sender: UIButton) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // URL button function (only displayed in read-only mode).
    @IBAction func urlButtonTapped(sender: AnyObject) {
    }
}
