//
//  CharacerModel.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 04/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import Foundation

struct CharacterModelItems: Codable {
    let lastModified: Int
    let name: String
    let realm: String
    let `class`: Int
    let thumbnail: String
    let items: Items

}

struct Items: Codable {
    let averageItemLevel, averageItemLevelEquipped: Int
    let neck: Neck
    let back: Back
    let wrist: Wrist
    let hands: Hands
    let waist: Waist
    let legs: Legs
    let feet: Feet
    let finger1: Finger1
    let finger2: Finger2
    let trinket1: Trinket1
    let trinket2: Trinket2
    let mainHand: MainHand
    let offHand: OffHand?
}

struct Neck: Codable {
    let azeriteItem: AzeriteItem?
}

struct Back: Codable {
    let tooltipParams: BackTooltipParams
}

struct AzeriteItem: Codable {
    let azeriteLevel: Int
}

struct BackTooltipParams: Codable {
    let gem0: Int?
}

struct Feet: Codable {
    let tooltipParams: FeetTooltipParams
}

struct FeetTooltipParams: Codable {
    let gem0: Int?
}

struct Finger1: Codable {
    let tooltipParams: Finger1TooltipParams
}

struct Finger1TooltipParams: Codable {
    let enchant: Int?
    let gem0: Int?
}

struct Finger2: Codable {
    let tooltipParams: Finger2TooltipParams
}

struct Finger2TooltipParams: Codable {
    let enchant: Int?
    let gem0: Int?
}

struct MainHand: Codable {
    let tooltipParams: MainHandTooltipParams
}

struct MainHandTooltipParams: Codable {
    let enchant: Int?
    let gem0: Int?
}

struct OffHand: Codable {
    let tooltipParams: OffHandTooltipParams
}

struct OffHandTooltipParams: Codable {
    let gem0: Int?
}

struct Trinket1: Codable {
    let tooltipParams: Trinket1TooltipParams
}

struct Trinket1TooltipParams: Codable {
    let gem0: Int?
}

struct Trinket2: Codable {
    let tooltipParams: Trinket2TooltipParams
}

struct Trinket2TooltipParams: Codable {
    let gem0: Int?
}

struct Wrist: Codable {
    let tooltipParams: WristTooltipParams
}

struct WristTooltipParams: Codable {
    let gem0: Int?
}

struct Hands: Codable {
    let tooltipParams: HandsTooltipParams
}

struct HandsTooltipParams: Codable {
    let gem0: Int?
}

struct Waist: Codable {
    let tooltipParams: WaistTooltipParams
}

struct WaistTooltipParams: Codable {
    let gem0: Int?
}

struct Legs: Codable {
    let tooltipParams: LegsTooltipParams
}

struct LegsTooltipParams: Codable {
    let gem0: Int?
}
