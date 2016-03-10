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
//    var filmImageCache = [UIImage]()
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext // Get the 'managedObjectContext' property from the AppDelegate.
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title of the Nav Bar to be the App Logo.
        let appLogo = UIImage(named: "FavouriteFilmsLogo")
        let imageView = UIImageView(image: appLogo)
        imageView.contentMode = .ScaleAspectFit
        imageView.bounds.size.height = 30
        navigationItem.titleView = imageView
        navigationItem.titleView!.contentMode = .ScaleAspectFit
        
        // Blank button added to the left of the Nav Bar to keep the logo centred (a bit hacky but it works).
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil)
        navigationItem.leftBarButtonItem?.enabled = false
        
        // Set the text of the default 'Back' button (no text, just the arrow).
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 107.0
        
        // Allows touches on the button in FilmCell to highlight correctly.
        tableView.delaysContentTouches = false
        for view in tableView.subviews {
            if view is UIScrollView {
                (view as? UIScrollView)!.delaysContentTouches = false
                break
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.fetchAndSetResults()
        self.tableView.reloadData()
        
    }
    
    // Retriveve the film data from core data.
    func fetchAndSetResults() {
        let fetchRequest = NSFetchRequest(entityName: "Film") // Set up for an actual data fetch request for the specified entity name.
        
        do {
            let results = try context.executeFetchRequest(fetchRequest) // Try to perform the actual fetch request and catch the error if it fails.
            self.films = results as! [Film] // Pass the fetched films in to the films array.
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    // MARK: - TableView Functions
    
    // Configure the table view cell, and make reusable.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("FilmCell") as? FilmCell {
            let film = films[indexPath.row]
            if indexPath.row < GlobalVars.filmImageCache.count {
                let img = GlobalVars.filmImageCache[indexPath.row]
                cell.configureCell(film, cachedImage: img)
            } else {
                cell.configureCell(film, cachedImage: nil)
                // Save the fetched film image to the cache.
                GlobalVars.filmImageCache[indexPath.row] = cell.filmImage.image
            }
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
    
    // Swipe a table view cell to delete a film.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Locate the film to delete (i.e. the swiped film).
            let filmToDelete = films[indexPath.row]
            // Delete the film from the managedObjectContext.
            context.deleteObject(filmToDelete)
            // Remove the film's image from the image cache.
            GlobalVars.filmImageCache.removeValueForKey(indexPath.row)
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
    
    @IBAction func urlButtonTapped(sender: AnyObject) {
        // Get the IndexPath of the cell that that button is in.
        var cellIndexPath: NSIndexPath!
        if let button = sender as? UIButton {
            if let view = button.superview {
                if let cell = view.superview as? FilmCell {
                    cellIndexPath = tableView.indexPathForCell(cell)
                }
            }
        }
        let film = films[cellIndexPath.row]
        
        performSegueWithIdentifier("goToWebView", sender: film)
    }
    
    // MARK: - Segue Preparation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetailVCAdd" {
            if let detailVC = segue.destinationViewController as? DetailVC {
                detailVC.navBar.title = "Add a Film"
                detailVC.newRecord = true
            }
        }
        
        if segue.identifier == "goToDetailVCRead" {
            if let detailVC = segue.destinationViewController as? DetailVC {
                detailVC.selectedFilm = sender as? Film
                detailVC.navBar.title = "Film Details"
                detailVC.newRecord = false
            }
        }
        
        if segue.identifier == "goToWebView" {
            if let webViewVC = segue.destinationViewController as? WebViewVC {
                if let film = sender as? Film {
                    webViewVC.navBar.title = "imdb.com"
                    webViewVC.incomingUrl = film.url
                }
            }
        }
    }
}