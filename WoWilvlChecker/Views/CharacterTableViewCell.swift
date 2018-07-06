//
//  CharacterTableViewCell.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 23/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import UIKit
import SwipeCellKit

class CharacterTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var characterDataLabel: UILabel!
    @IBOutlet weak var characterThumbnail: UIImageView!
    @IBOutlet weak var characterBackground: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        delegate = self as? SwipeTableViewCellDelegate
        
        characterBackground.layer.cornerRadius = 20
        
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}

//extension SwipeTableViewCellDelegate {
//    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//            // handle action by updating model with deletion
//            self.updateModel(at: indexPath)
//        }
//        
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete-icon")
//
//        return [deleteAction]
//    }
//
//        func updateModel(at indexPath: IndexPath) {
//            // Update our data model
//        }
//    
//}
