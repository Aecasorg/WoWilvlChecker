//
//  CharacterModelAudit.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 13/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import Foundation

struct CharacterModelAudit: Codable {
    let lastModified: Int
    let name, realm, battlegroup: String
    let characterModelAuditClass, race, gender, level: Int
    let achievementPoints: Int
    let thumbnail, calcClass: String
    let faction: Int
    let audit: Audit
    let totalHonorableKills: Int
    
    enum CodingKeys: String, CodingKey {
        case lastModified, name, realm, battlegroup
        case characterModelAuditClass = "class"
        case race, gender, level, achievementPoints, thumbnail, calcClass, faction, audit, totalHonorableKills
    }
}

struct Audit: Codable {
    let numberOfIssues: Int
    let slots: [String: Int]
    let emptyGlyphSlots, unspentTalentPoints: Int
    let noSpec: Bool
    let unenchantedItems: [String: Int]
    let emptySockets: Int
    let itemsWithEmptySockets: InappropriateArmorType
    let appropriateArmorType: Int
    let inappropriateArmorType, lowLevelItems: InappropriateArmorType
    let lowLevelThreshold: Int
    let missingExtraSockets: MissingExtraSockets
//    let recommendedBeltBuckle: RecommendedBeltBuckle
    let missingBlacksmithSockets, missingEnchanterEnchants: InappropriateArmorType
    let missingEngineerEnchants: [String: Int]
    let missingScribeEnchants: InappropriateArmorType
    let nMissingJewelcrafterGems: Int
    let missingLeatherworkerEnchants: InappropriateArmorType
}

struct InappropriateArmorType: Codable {
}

struct MissingExtraSockets: Codable {
    let the5: Int
    
    enum CodingKeys: String, CodingKey {
        case the5 = "5"
    }
}

//struct RecommendedBeltBuckle: Codable {
//    let id: Int
//    let description, name, icon: String
//    let stackable, itemBind: Int
//    let bonusStats: [JSONAny]
//    let itemSpells: [ItemSpell]
//    let buyPrice, itemClass, itemSubClass, containerSlots: Int
//    let inventoryType: Int
//    let equippable: Bool
//    let itemLevel, maxCount, maxDurability, minFactionID: Int
//    let minReputation, quality, sellPrice, requiredSkill: Int
//    let requiredLevel, requiredSkillRank: Int
//    let itemSource: ItemSource
//    let baseArmor: Int
//    let hasSockets, isAuctionable: Bool
//    let armor, displayInfoID: Int
//    let nameDescription, nameDescriptionColor: String
//    let upgradable, heroicTooltip: Bool
//    let context: String
//    let bonusLists: [JSONAny]
//    let availableContexts: [String]
//    let bonusSummary: BonusSummary
//    let artifactID: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id, description, name, icon, stackable, itemBind, bonusStats, itemSpells, buyPrice, itemClass, itemSubClass, containerSlots, inventoryType, equippable, itemLevel, maxCount, maxDurability
//        case minFactionID = "minFactionId"
//        case minReputation, quality, sellPrice, requiredSkill, requiredLevel, requiredSkillRank, itemSource, baseArmor, hasSockets, isAuctionable, armor
//        case displayInfoID = "displayInfoId"
//        case nameDescription, nameDescriptionColor, upgradable, heroicTooltip, context, bonusLists, availableContexts, bonusSummary
//        case artifactID = "artifactId"
//    }
//}

//struct BonusSummary: Codable {
//    let defaultBonusLists, chanceBonusLists, bonusChances: [JSONAny]
//}

struct ItemSource: Codable {
    let sourceID: Int
    let sourceType: String
    
    enum CodingKeys: String, CodingKey {
        case sourceID = "sourceId"
        case sourceType
    }
}

