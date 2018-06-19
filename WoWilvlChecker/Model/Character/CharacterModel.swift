//
//  CharacterModel.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 17/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import Foundation

class CharacterModel {
    
    var lastModified: Int = 0
    let name: String
    let realm: String
    var `class`: Int = 0
    var thumbnail: String = ""
    var averageItemLevelEquipped: Int = 0
    var neckEnchant: Bool = false
    var backEnchant: Bool = false
    var finger1Enchant: Bool = false
    var finger2Enchant: Bool = false
    var spec: String = ""
    var role: String = ""
    var emptySockets: Int = 0
    
    init(name: String, realm: String) {
        self.name = name
        self.realm = realm
    }
    
}
