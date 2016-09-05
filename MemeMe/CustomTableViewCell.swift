//
//  CustomTableViewCell.swift
//  MemeMe
//
//  Created by AhmedFathi on 8/30/16.
//  Copyright © 2016 AhmedFathi. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var memedImage: UIImageView!
    @IBOutlet weak var combinedText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
