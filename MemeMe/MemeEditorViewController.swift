//
//  NewMemeViewController.swift
//  MemeMe
//
//  Created by AhmedFathi on 8/29/16.
//  Copyright © 2016 AhmedFathi. All rights reserved.
//

import UIKit


class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    //MARK: Outlets
    
    var top: String = ""
    var bottom: String = ""
    var image: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    var viewDidMove: Bool!
    
    //MARK: -
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // only unlock camera button if camera is available on the device
        self.cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        self.viewDidMove = false
        
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        
        self.reloadData()
        
        // Stop Editing when tap anywhere on the screen
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotification()
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotification()
    }
    
    
    
    //MARK: -
    
    //MARK: Helper Functions
    
    func reloadData() {
        self.topTextField.text = self.top
        self.bottomTextField.text = self.bottom
        self.imageView.image = self.image
    }
    
    func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    // Moves View up when keyboard is about to appear
    
    func keyboardWillShow(notification: NSNotification) {
        if !self.viewDidMove {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
            self.viewDidMove = true
        }
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    
    func keyboardWillHide(notification: NSNotification) {
        if self.viewDidMove == true {
            self.view.frame.origin.y += getKeyboardHeight(notification)
            self.viewDidMove = false
        }
    }
    
    
    func unsubscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Create a meme object and add it to the memes array
    func save() {
        
        // Update the meme
        let meme = Meme(top: topTextField.text!, bottom: bottomTextField.text!, image: imageView.image!, memedImage: generateMemedImage())
        
        // Add it to the memes array on the Application Delegate
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        
    }
    
    
    // Create a UIImage that combines the Image View and the Labels
    func generateMemedImage() -> UIImage {
        
        // render view to an image
        UIGraphicsBeginImageContext(self.imageView.frame.size)
        self.view.drawViewHierarchyInRect(self.imageView.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
        
    }
    

    
    
    
    //MARK: - IBActions
    
    //MARK: -Top Bar
    
    @IBAction func shareMeme(sender: AnyObject) {
        if let image = self.imageView.image {
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            self.save()
            presentViewController(activityVC, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Ops!!", message: "Please select image to share it", preferredStyle: UIAlertControllerStyle.ActionSheet)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }

    
    // Cancel editing the New Meme
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //MARK: -Bottom Bar
    
    // Pick photo for your meme from Camera
    
    @IBAction func camera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Pick photo for your meme from Album
    
    @IBAction func album(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    //MARK: - Delegation
    //MARK: -Image Picker Delegate
    
    // Put selected image in the imageView
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
            self.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    //MARK: -Text Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.dismissKeyboard()
        self.top = self.topTextField.text!
        self.bottom = self.bottomTextField.text!
        return true
    }

}












