//
//  CharacterModel.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 17/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import Foundation
import ObjectBox

class CharacterModel: Entity {
    
    required init() {
        // nothing to do here, ObjectBox calls this
    }
    
    var charID: Id<CharacterModel> = 0
    var lastModified: Int = 0
    var charName: String = ""
    var charRealm: String = ""
    var charClass: Int = 0
    var thumbnail: String = ""
    var averageItemLevelEquipped: Int = 0
    var neckLevel: Int = 0
    var spec: String = ""
    var role: String = ""
    var emptySockets: Int = 0
    var numberOfEnchants: Int = 0
    var numberOfGems: Int = 0
    var totalNumberOfEnchants: Int = 0
    
}
