//
//  CharacterModelTalents.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 13/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import Foundation

struct CharacterModelTalents: Codable {
    let lastModified: Int
    let name, realm, battlegroup: String
    let characterDataClass, race, gender, level: Int
    let achievementPoints: Int
    let thumbnail, calcClass: String
    let faction: Int
    let talents: [CharacterDataTalent]
    let totalHonorableKills: Int
    
    enum CodingKeys: String, CodingKey {
        case lastModified, name, realm, battlegroup
        case characterDataClass = "class"
        case race, gender, level, achievementPoints, thumbnail, calcClass, faction, talents, totalHonorableKills
    }
}

struct CharacterDataTalent: Codable {
    let spec: Spec?
    let selected: Bool?
}

struct Spec: Codable {
    let name: String
    let role: String
    let backgroundImage: String
    let icon: String
    let description: String
    let order: Int
}
