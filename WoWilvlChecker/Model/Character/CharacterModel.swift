//
//  CharacterModel.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 17/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import Foundation
import RealmSwift

class CharacterModel: Object {
    
    @objc dynamic var charID = UUID().uuidString
    @objc dynamic var lastModified: Int = 0
    @objc dynamic var charName: String = ""
    @objc dynamic var charRealm: String = ""
    @objc dynamic var charClass: Int = 0
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var averageItemLevelEquipped: Int = 0
    @objc dynamic var neckLevel: Int = 0
    @objc dynamic var finger1Enchant: Bool = false
    @objc dynamic var finger2Enchant: Bool = false
    @objc dynamic var mainHandEnchant: Bool = false
    @objc dynamic var spec: String = ""
    @objc dynamic var role: String = ""
    @objc dynamic var emptySockets: Int = 0
    @objc dynamic var numberOfEnchants: Int = 0
    
    override static func primaryKey() -> String? {
        return "charID"
    }
    
}
