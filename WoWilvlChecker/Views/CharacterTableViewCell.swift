//
//  CharacterTableViewCell.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 23/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import UIKit
import Alamofire

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterDataLabel: UILabel!
    @IBOutlet weak var characterThumbnail: UIImageView!
    @IBOutlet weak var characterBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setupCell() {
        
        characterBackground.layer.cornerRadius = 20.0
        
        characterThumbnail.sizeToFit()
        characterThumbnail.layer.cornerRadius = 15.0
        characterThumbnail.clipsToBounds = true
        characterThumbnail.layer.masksToBounds = true
        
    }

}
