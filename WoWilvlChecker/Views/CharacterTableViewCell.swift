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
        
        
        
//        DispatchQueue.main.async {
//            self.characterThumbnail.layer.cornerRadius = 15
//            self.characterThumbnail.layer.masksToBounds = true
//        }
        
        
        
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCell() {
        
        characterBackground.layer.cornerRadius = 5.0
        
        characterThumbnail.sizeToFit()
        characterThumbnail.layer.cornerRadius = 5.0
        characterThumbnail.clipsToBounds = true
        characterThumbnail.layer.masksToBounds = true
        
    }

}
