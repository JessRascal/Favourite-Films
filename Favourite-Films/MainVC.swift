//
//  MainVC.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 20/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var films = [Film]()
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext // Get the 'managedObjectContext' property from the AppDelegate.
    
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 107.0
    }
    
    // MARK: - Functions
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
    }
    
    func fetchAndSetResults() {
        let fetchRequest = NSFetchRequest(entityName: "Film") // Set up for an actual data fetch request for the specific entity.
        
        do {
            let results = try context.executeFetchRequest(fetchRequest) // Try to perform the actual fetch request and catch the error if it fails.
            self.films = results as! [Film]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    // MARK: - TableView Functions
    
    // Configure the table view cell, and make reusable.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("FilmCell") as? FilmCell {
            let film = films[indexPath.row]
            cell.configureCell(film)
            return cell
        } else {
            return FilmCell()
        }
    }
    
    // Define the number of sections in the table view.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Define the number of rows in the table view.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    // Tap the table view cell to view the film details.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let film = films[indexPath.row]
        performSegueWithIdentifier("goToDetailVCRead", sender: film)
    }
    
    // Swipe a table view cell to edit or delete a film.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {

            // Locate the film to delete (i.e. the swiped film).
            let filmToDelete = films[indexPath.row]
            // Delete the film from the managedObjectContext.
            context.deleteObject(filmToDelete)
            // Re-fetch the data from core data.
            fetchAndSetResults()
            // Remove the deleted row from the table.
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(sender: AnyObject!) {
        performSegueWithIdentifier("goToDetailVCAdd", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetailVCAdd" {
            if let detailVC = segue.destinationViewController as? DetailVC {
                detailVC.navTitle.title = "Add a Film"
                detailVC.newRecord = true
            }
        }
        
        if segue.identifier == "goToDetailVCRead" {
            if let detailVC = segue.destinationViewController as? DetailVC {
                detailVC.navTitle.title = "Film Details"
                detailVC.newRecord = false
                detailVC.selectedFilm = sender as? Film
            }
        }
    }
}

