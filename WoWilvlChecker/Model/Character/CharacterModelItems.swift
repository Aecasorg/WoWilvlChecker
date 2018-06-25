//
//  CharacerModel.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 04/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import Foundation

//struct CharacterModelItems: Codable {
//
//    var charName, charRealm, charAvatar: String
//    var lastModified: Int
//    var charilvl: Int
//    //    let charName, charRealm, charSpec, charAvatar: String
//    //    let charClass, charilvl, charEnchants, charGems: Int
//
//    enum CodingKeys: String, CodingKey {
//        case lastModified
//        case charName = "name"
//        case charRealm = "realm"
//        case charAvatar = "thumbnail"
//        case items
//    }
//
//    enum ItemsCodingKeys: String, CodingKey {
//        case charilvl = "averageItemLevelEquipped"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        lastModified = try container.decode(Int.self, forKey: .lastModified)
//        charName = try container.decode(String.self, forKey: .charName)
//        charRealm = try container.decode(String.self, forKey: .charRealm)
//        charAvatar = try container.decode(String.self, forKey: .charAvatar)
//        let items = try container.nestedContainer(keyedBy: ItemsCodingKeys.self, forKey: .items)
//        charilvl = try items.decode(Int.self, forKey: .charilvl)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(lastModified, forKey: .lastModified)
//        try container.encode(charName, forKey: .charName)
//        try container.encode(charRealm, forKey: .charRealm)
//        try container.encode(charAvatar, forKey: .charAvatar)
//
//        var items = container.nestedContainer(keyedBy: ItemsCodingKeys.self, forKey: .items)
//        try items.encode(charilvl, forKey: .charilvl)
//    }
//
//}


struct CharacterModelItems: Codable {
    let lastModified: Int
    let name: String
    let realm: String
//    let battlegroup: String
    let `class`: Int
//    let characterModelItemsClass, race, gender, level: Int
//    let achievementPoints: Int
    let thumbnail: String
//    let calcClass: String
//    let faction: Int
    let items: Items
//    let totalHonorableKills: Int
    
//    enum CodingKeys: String, CodingKey {
//        case lastModified, name, realm, battlegroup
//        case characterModelItemsClass = "class"
//        case race, gender, level, achievementPoints, thumbnail, calcClass, faction, items, totalHonorableKills
//    }
}

struct Items: Codable {
    let averageItemLevel, averageItemLevelEquipped: Int
//    let head: Feet
    let neck: Neck
//    let shoulder: Feet
    let back: Back
//    let chest: Chest
//    let shirt: Feet
//    let wrist: Wrist
//    let hands, waist, legs, feet: Feet
    let finger1: Finger1
    let finger2: Finger2
//    let trinket1, trinket2: Trinket
//    let mainHand: MainHand
}

struct Neck: Codable {
    let tooltipParams: Appearance
}

struct Back: Codable {
//    let id: Int
//    let name, icon: String
//    let quality, itemLevel: Int
//    let tooltipParams: BackTooltipParams
//    let stats: [Stat]
//    let armor: Int
//    let context: String
//    let bonusLists: [Int]
//    let artifactID, displayInfoID, artifactAppearanceID: Int
//    let artifactTraits, relics: [JSONAny]
    let tooltipParams: Appearance
    
//    enum CodingKeys: String, CodingKey {
//        case id, name, icon, quality, itemLevel, tooltipParams, stats, armor, context, bonusLists
//        case artifactID = "artifactId"
//        case displayInfoID = "displayInfoId"
//        case artifactAppearanceID = "artifactAppearanceId"
//        case artifactTraits, relics, appearance
//    }
}

struct Appearance: Codable {
//    let itemID: Int?
    let enchant: Int?
//    let itemAppearanceModID, transmogItemAppearanceModID: Int?
    
//    enum CodingKeys: String, CodingKey {
//        case itemID = "itemId"
//        case enchantDisplayInfoID = "enchantDisplayInfoId"
//        case itemAppearanceModID = "itemAppearanceModId"
//        case transmogItemAppearanceModID = "transmogItemAppearanceModId"
//    }
}

//struct Stat: Codable {
//    let stat, amount: Int
//}

//struct BackTooltipParams: Codable {
//    let enchant, transmogItem, timewalkerLevel: Int?
//}

//struct Chest: Codable {
//    let id: Int
//    let name, icon: String
//    let quality, itemLevel: Int
//    let tooltipParams: ChestTooltipParams
//    let stats: [Stat]
//    let armor: Int
//    let context: String
//    let bonusLists: [Int]
//    let artifactID, displayInfoID, artifactAppearanceID: Int
////    let artifactTraits, relics: [JSONAny]
//    let appearance: Appearance
//
////    enum CodingKeys: String, CodingKey {
////        case id, name, icon, quality, itemLevel, tooltipParams, stats, armor, context, bonusLists
////        case artifactID = "artifactId"
////        case displayInfoID = "displayInfoId"
////        case artifactAppearanceID = "artifactAppearanceId"
////        case artifactTraits, relics, appearance
////    }
//}

//struct ChestTooltipParams: Codable {
//    let tooltipParamsSet: [Int]
//    let transmogItem, timewalkerLevel: Int
//
////    enum CodingKeys: String, CodingKey {
////        case tooltipParamsSet = "set"
////        case transmogItem, timewalkerLevel
////    }
//}

//struct Feet: Codable {
//    let id: Int
//    let name, icon: String
//    let quality, itemLevel: Int
//    let tooltipParams: FeetTooltipParams
//    let stats: [Stat]
//    let armor: Int
//    let context: String
//    let bonusLists: [Int]
//    let artifactID, displayInfoID, artifactAppearanceID: Int
////    let artifactTraits, relics: [JSONAny]
//    let appearance: Appearance
//
////    enum CodingKeys: String, CodingKey {
////        case id, name, icon, quality, itemLevel, tooltipParams, stats, armor, context, bonusLists
////        case artifactID = "artifactId"
////        case displayInfoID = "displayInfoId"
////        case artifactAppearanceID = "artifactAppearanceId"
////        case artifactTraits, relics, appearance
////    }
//}
//
//struct FeetTooltipParams: Codable {
//    let transmogItem, timewalkerLevel: Int
//}

struct Finger1: Codable {
//    let id: Int
//    let name, icon: String
//    let quality, itemLevel: Int
//    let tooltipParams: Finger1TooltipParams
//    let stats: [Stat]
//    let armor: Int
//    let context: String
//    let bonusLists: [Int]
//    let artifactID, displayInfoID, artifactAppearanceID: Int
//    let artifactTraits, relics: [JSONAny]
    let tooltipParams: Finger1Appearance
    
//    enum CodingKeys: String, CodingKey {
//        case id, name, icon, quality, itemLevel, tooltipParams, stats, armor, context, bonusLists
//        case artifactID = "artifactId"
//        case displayInfoID = "displayInfoId"
//        case artifactAppearanceID = "artifactAppearanceId"
//        case artifactTraits, relics, appearance
//    }
}

struct Finger1Appearance: Codable {
    let enchant: Int?
//    let itemAppearanceModID: Int?
    
//    enum CodingKeys: String, CodingKey {
//        case enchantDisplayInfoID = "enchantDisplayInfoId"
//        case itemAppearanceModID = "itemAppearanceModId"
//    }
}

//struct Finger1TooltipParams: Codable {
//    let gem0, enchant, timewalkerLevel: Int?
//}

struct Finger2: Codable {
//    let id: Int
//    let name, icon: String
//    let quality, itemLevel: Int
//    let tooltipParams: Finger2TooltipParams
//    let stats: [Stat]
//    let armor: Int
//    let context: String
//    let bonusLists: [Int]
//    let artifactID, displayInfoID, artifactAppearanceID: Int
//    let artifactTraits, relics: [JSONAny]
    let tooltipParams: Finger2Appearance
    
//    enum CodingKeys: String, CodingKey {
//        case id, name, icon, quality, itemLevel, tooltipParams, stats, armor, context, bonusLists
//        case artifactID = "artifactId"
//        case displayInfoID = "displayInfoId"
//        case artifactAppearanceID = "artifactAppearanceId"
//        case artifactTraits, relics, appearance
//    }
}

struct Finger2Appearance: Codable {
    let enchant: Int?
    
//    enum CodingKeys: String, CodingKey {
//        case enchantDisplayInfoID = "enchantDisplayInfoId"
//    }
}

//struct Finger2TooltipParams: Codable {
//    let enchant, timewalkerLevel: Int?
//}

//struct MainHand: Codable {
//    let id: Int
//    let name, icon: String
//    let quality, itemLevel: Int
//    let tooltipParams: MainHandTooltipParams
//    let stats: [Stat]
//    let armor: Int
//    let weaponInfo: WeaponInfo
//    let context: String
//    let bonusLists: [Int]
//    let artifactID, displayInfoID, artifactAppearanceID: Int
//    let artifactTraits: [ArtifactTrait]
//    let relics: [Relic]
//    let appearance: Appearance
//
////    enum CodingKeys: String, CodingKey {
////        case id, name, icon, quality, itemLevel, tooltipParams, stats, armor, weaponInfo, context, bonusLists
////        case artifactID = "artifactId"
////        case displayInfoID = "displayInfoId"
////        case artifactAppearanceID = "artifactAppearanceId"
////        case artifactTraits, relics, appearance
////    }
//}

//struct ArtifactTrait: Codable {
//    let id, rank: Int
//}
//
//struct Relic: Codable {
//    let socket, itemID, context: Int
//    let bonusLists: [Int]
//
////    enum CodingKeys: String, CodingKey {
////        case socket
////        case itemID = "itemId"
////        case context, bonusLists
////    }
//}

//struct MainHandTooltipParams: Codable {
//    let gem0, gem1, gem2, transmogItem: Int
//    let timewalkerLevel: Int
//}

//struct WeaponInfo: Codable {
//    let damage: Damage
//    let weaponSpeed: Int
//    let dps: Double
//}

//struct Damage: Codable {
//    let min, max, exactMin, exactMax: Int
//}

//struct Trinket: Codable {
//    let id: Int
//    let name, icon: String
//    let quality, itemLevel: Int
//    let tooltipParams: Trinket1TooltipParams
//    let stats: [Stat]
//    let armor: Int
//    let context: String
//    let bonusLists: [Int]
//    let artifactID, displayInfoID, artifactAppearanceID: Int
////    let artifactTraits, relics: [JSONAny]
//    let appearance: Trinket1Appearance
//
////    enum CodingKeys: String, CodingKey {
////        case id, name, icon, quality, itemLevel, tooltipParams, stats, armor, context, bonusLists
////        case artifactID = "artifactId"
////        case displayInfoID = "displayInfoId"
////        case artifactAppearanceID = "artifactAppearanceId"
////        case artifactTraits, relics, appearance
////    }
//}
//
//struct Trinket1Appearance: Codable {
//}
//
//struct Trinket1TooltipParams: Codable {
//    let timewalkerLevel: Int
//}

//struct Wrist: Codable {
//    let id: Int
//    let name, icon: String
//    let quality, itemLevel: Int
//    let tooltipParams: WristTooltipParams
//    let stats: [Stat]
//    let armor: Int
//    let context: String
//    let bonusLists: [Int]
//    let artifactID, displayInfoID, artifactAppearanceID: Int
////    let artifactTraits, relics: [JSONAny]
//    let appearance: Appearance
//
////    enum CodingKeys: String, CodingKey {
////        case id, name, icon, quality, itemLevel, tooltipParams, stats, armor, context, bonusLists
////        case artifactID = "artifactId"
////        case displayInfoID = "displayInfoId"
////        case artifactAppearanceID = "artifactAppearanceId"
////        case artifactTraits, relics, appearance
////    }
//}
//
//struct WristTooltipParams: Codable {
//    let gem0, transmogItem, timewalkerLevel: Int
//}
