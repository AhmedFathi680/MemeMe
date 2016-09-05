//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by AhmedFathi on 8/29/16.
//  Copyright © 2016 AhmedFathi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    

    //MARK: - Delegation
    
    //MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.memes.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
    
        // Configure the cell
        let meme = memes[indexPath.item]
        cell.setText(meme.top, bottom: meme.bottom)
        let imageView = UIImageView(image: meme.image)
        cell.backgroundView = imageView
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        let meme = memes[indexPath.item]
        
        let storyboard = self.storyboard!
        let memeEditorVC = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        
        memeEditorVC.top = meme.top
        memeEditorVC.bottom = meme.bottom
        memeEditorVC.image = meme.image
        
        presentViewController(memeEditorVC, animated: true, completion: nil)
        
        
    }
    
    
}












