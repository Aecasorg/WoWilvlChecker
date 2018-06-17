//
//  CharacterModel.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 17/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import Foundation

struct CharacterModel {
    
    let lastModified: Int
    let name: String
    let realm: String
    let `class`: Int
    let thumbnail: String
    let averageItemLevelEquipped: Int
    let neckEnchant: Bool
    let backEnchant: Bool
    let finger1Enchant: Bool
    let finger2Enchant: Bool
    let spec: String
    let role: String
    let emptySockets: Int
    
}
