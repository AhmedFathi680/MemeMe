//
//  CustomCollectionViewCell.swift
//  MemeMe
//
//  Created by AhmedFathi on 8/30/16.
//  Copyright © 2016 AhmedFathi. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var top: UILabel!
    @IBOutlet weak var bottom: UILabel!
    
    
    func setText(top: String, bottom: String) {
        self.top.text = top
        self.bottom.text = bottom
    }
}
