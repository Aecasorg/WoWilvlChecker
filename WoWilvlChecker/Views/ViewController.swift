//
//  ViewController.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 04/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var apiKey = "pgje56uws25hmdw426agmrkjcz4zbhuc"
    var name = "avalentica"
    var realm = "azjol-nerub"
    var fields = "talents"
    
    @IBAction func alamoResponseButtonPressed(_ sender: Any) {
        let blizzardURL = urlCreator(name: name, realm: realm, fields: fields)
        getCharacterData(url: blizzardURL)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    //MARK: - Networking
    /***************************************************************/
    
    func getCharacterData(url: String) {

        // Passing the data collected from the character search we use Alamofire to get the JSON data
        Alamofire.request(url).responseJSON {
            response in
            if response.result.isSuccess {

                print("Success!")
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                    print("Data: \(utf8Text)") // original server data as UTF8 string
//                    self.printData(data: data)
                    self.printDataTalents(data: data)
//                    self.printDataAudit(data: data)
                }

                
            } else {

                print("Error \(String(describing: response.result.error))")

            }

        }

    }
    
    func urlCreator(name: String, realm: String, fields: String) -> String {
        
        return "https://eu.api.battle.net/wow/character/\(realm)/\(name)?fields=\(fields)&locale=en_GB&apikey=\(apiKey)"
        
    }
    
    func printData(data: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(CharacterModelItems.self, from: data)
            print(decoded)
            print("Character last modified: \(decoded.lastModified)")
            print("Character Name: " + decoded.name)
            print("Character Realm: " + decoded.realm)
            print("Character Avatar: " + decoded.thumbnail)
            print("Character ilvl: \(decoded.items.averageItemLevelEquipped)")
            
            if let neck = decoded.items.neck.tooltipParams.enchant {
                print("Neck enchant: \(neck)")
            } else {
                print("No neck enchant!")
            }
            
            if let back = decoded.items.back.tooltipParams.enchant {
                print("Back enchant: \(back)")
            } else {
                print("No back enchant!")
            }
            
            if let finger1 = decoded.items.finger1.tooltipParams.enchant {
                print("Finger1 enchant: \(finger1)")
            } else {
                print("No finger1 enchant!")
            }
            
            if let finger2 = decoded.items.finger2.tooltipParams.enchant {
                print("Finger2 enchant: \(finger2)")
            } else {
                print("No finger2 enchant!")
            }
            
        } catch {
            print("Failed to decode JSON")
        }
        
    }
    
    func printDataTalents(data: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(CharacterModelTalents.self, from: data)
//            print(decoded)
            print("Character last modified: \(decoded.lastModified)")
            print("Character Name: " + decoded.name)
            print("Character Realm: " + decoded.realm)
            print("Character Avatar: " + decoded.thumbnail)
            if decoded.talents[0].selected ?? false {
                print("Character talents: \(decoded.talents[0].spec!.name)")
                print("Character role: \(decoded.talents[0].spec!.role)")
            } else if decoded.talents[1].selected ?? false {
                print("Character talents: \(decoded.talents[1].spec!.name)")
                print("Character role: \(decoded.talents[1].spec!.role)")
            } else if decoded.talents[2].selected ?? false {
                print("Character talents: \(decoded.talents[2].spec!.name)")
                print("Character role: \(decoded.talents[2].spec!.role)")
            } else if decoded.talents[3].selected ?? false {
                print("Character talents: \(decoded.talents[3].spec!.name)")
                print("Character role: \(decoded.talents[3].spec!.role)")
            } else {
                print("Spec missing!")
            }
        } catch {
            print("Failed to decode JSON")
        }
        
    }
    
    func printDataAudit(data: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(CharacterModelAudit.self, from: data)
            print(decoded)
            print("Character last modified: \(decoded.lastModified)")
            print("Character Name: " + decoded.name)
            print("Character Realm: " + decoded.realm)
            print("Character Avatar: " + decoded.thumbnail)
            print("Character empty sockets: \(decoded.audit.emptySockets)")
            print("Character unenchanted items: \(decoded.audit.unenchantedItems)")
        } catch {
            print("Failed to decode JSON")
        }
        
    }

}

//struct CharacterModelItems: Codable {
//
//    struct Items: Codable {
//        var averageItemLevelEquipped: Int
//
//    }
//
//    var items: Items
//    var charName, charRealm, charAvatar: String
//    var lastModified: Int
//
//}

// MARK: - Character Model Item Level Parser
//struct CharacterModelItems: Codable {
//
//    var charName, charRealm, charAvatar: String
//    var lastModified: Int
//    var charilvl: Int
////    let charName, charRealm, charSpec, charAvatar: String
////    let charClass, charilvl, charEnchants, charGems: Int
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

// MARK: - Character Model Talents Parser
//struct CharacterModelTalents: Codable {
//    let lastModified: Int
//    let name, realm, battlegroup: String
//    let characterDataClass, race, gender, level: Int
//    let achievementPoints: Int
//    let thumbnail, calcClass: String
//    let faction: Int
//    let talents: [CharacterDataTalent]
//    let totalHonorableKills: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case lastModified, name, realm, battlegroup
//        case characterDataClass = "class"
//        case race, gender, level, achievementPoints, thumbnail, calcClass, faction, talents, totalHonorableKills
//    }
//}
//
//struct CharacterDataTalent: Codable {
//    let talents: [TalentTalent]
//    let spec: Spec?
//    let calcTalent, calcSpec: String
//    let selected: Bool?
//}
//
//struct Spec: Codable {
//    let name: String
//    let role: String
//    let backgroundImage: String
//    let icon: String
//    let description: String
//    let order: Int
//}
//
//struct TalentTalent: Codable {
//    let tier, column: Int
//    let spell: Spell
//    let spec: Spec?
//}
//
//struct Spell: Codable {
//    let id: Int
//    let name, icon, description: String
//    let castTime: String
//    let cooldown, range, powerCost: String?
//}


// MARK: - Character Model Audit Parser
