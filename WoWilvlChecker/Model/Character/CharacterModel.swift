//
//  CharacerModel.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 04/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import Foundation

class CharacterModel {
    
    let charName, charRealm, charSpec: String
    let charClass, charilvl, charEnchants, charGems: Int
    
    init(charName: String, charRealm: String, charClass: Int) {
        self.charName = charName
        self.charRealm = charRealm
        self.charSpec = ""
        self.charClass = charClass
        self.charilvl = 0
        self.charEnchants = 0
        self.charGems = 0
    }
    
}
