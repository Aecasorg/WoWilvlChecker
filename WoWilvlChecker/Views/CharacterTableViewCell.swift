//
//  CharacterTableViewCell.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 23/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import UIKit
import Alamofire
import SwipeCellKit

class CharacterTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var characterDataLabel: UILabel!
    @IBOutlet weak var characterThumbnail: UIImageView!
    @IBOutlet weak var characterBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        delegate = self as? SwipeTableViewCellDelegate
        
    }
    
    func setupCell() {
        
        characterBackground.layer.cornerRadius = 20.0
        
        characterThumbnail.sizeToFit()
        characterThumbnail.layer.cornerRadius = 15.0
        characterThumbnail.clipsToBounds = true
        characterThumbnail.layer.masksToBounds = true
        
    }

}
