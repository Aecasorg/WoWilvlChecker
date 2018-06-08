//
//  CharacterFunctions.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 05/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import Foundation

class CharacterFunctions {
    
    static func createCharacter(characterModel: CharacterModel) {
        
    }
    
    static func readCharacters(completion: @escaping () -> ()) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.charModels.count == 0 {
                Data.charModels.append(CharacterModel(charName: "Annebelle", charRealm: "Azjol-Nerub", charClass: 10))
                Data.charModels.append(CharacterModel(charName: "Liira", charRealm: "Azjol-Nerub", charClass: 3))
                Data.charModels.append(CharacterModel(charName: "Belangel", charRealm: "Azjol-Nerub", charClass: 2))
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    static func updateCharacter(characterModel: CharacterModel) {
        
    }
    
    static func deleteCharacter(characterModel: CharacterModel) {
        
    }
    
}
