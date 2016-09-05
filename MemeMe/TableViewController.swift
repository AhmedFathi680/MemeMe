//
//  TableViewController.swift
//  MemeMe
//
//  Created by AhmedFathi on 8/29/16.
//  Copyright © 2016 AhmedFathi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TableViewCell"

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        
        // Configure the cell
        let meme = memes[indexPath.row]
        cell.memedImage?.image = meme.memedImage
        cell.combinedText?.text = "\(meme.top) ... \(meme.bottom)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let meme = memes[indexPath.row]
        
        let storyboard = self.storyboard!
        let memeEditorVC = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        
        memeEditorVC.top = meme.top
        memeEditorVC.bottom = meme.bottom
        memeEditorVC.image = meme.image
        
        presentViewController(memeEditorVC, animated: true, completion: nil)
    }
    
}



