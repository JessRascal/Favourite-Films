//
//  ViewController.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 20/02/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var films = [Film]()
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 107.0
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
    }
    
    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate // Get the AppDelegate.
        let context = app.managedObjectContext // Get the 'managedObjectContext' property (the "data waiting room").
        let fetchRequest = NSFetchRequest(entityName: "Film") // Set up for an actual data fetch request for the specific entity.
        
        do {
            let results = try context.executeFetchRequest(fetchRequest) // Try to perform the actual fetch request and catch the error if it fails.
            self.films = results as! [Film]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    // MARK: - TableView Functions
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("FilmCell") as? FilmCell {
            let film = films[indexPath.row]
            cell.configureCell(film)
            return cell
        } else {
            return FilmCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Use for row selection.
    }
    
    
    // MARK: - Actions
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

