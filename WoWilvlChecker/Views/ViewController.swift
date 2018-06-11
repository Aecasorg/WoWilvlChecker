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
    var name = "annebelle"
    var realm = "azjol-nerub"
    var fields = "items"
    var blizzardURL = ""
    
    @IBAction func alamoResponseButtonPressed(_ sender: Any) {
        blizzardURL = urlCreator(name: name, realm: realm, fields: fields)
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
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                    self.printData(data: data)
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
            let decoded = try decoder.decode(CharacterModel.self, from: data)
            print(decoded)
            print("Character Name: " + decoded.charName)
            print("Character Realm: " + decoded.charRealm)
            print("Character Avatar: " + decoded.charAvatar)
            print("Character ilvl: \(decoded.charilvl)")
        } catch {
            print("Failed to decode JSON")
        }
        
    }

}

struct CharacterModel: Codable {

    let charName, charRealm, charAvatar: String
    let charilvl: Int?
//    let charName, charRealm, charSpec, charAvatar: String
//    let charClass, charilvl, charEnchants, charGems: Int
    
    enum CodingKeys: String, CodingKey {
        case charName = "name"
        case charRealm = "realm"
        case charAvatar = "thumbnail"
        case items
    }
    
    enum ItemsCodingKeys: String, CodingKey {
        case charilvl = "averageItemLevelEquipped"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        charName = try container.decode(String.self, forKey: .charName)
        charRealm = try container.decode(String.self, forKey: .charRealm)
        charAvatar = try container.decode(String.self, forKey: .charAvatar)
        let items = try container.nestedContainer(keyedBy: ItemsCodingKeys.self, forKey: .items)
        charilvl = try items.decode(Int.self, forKey: .charilvl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(charName, forKey: .charName)
        try container.encode(charRealm, forKey: .charRealm)
        try container.encode(charAvatar, forKey: .charAvatar)
        
        var items = container.nestedContainer(keyedBy: ItemsCodingKeys.self, forKey: .items)
        try items.encode(charilvl, forKey: .charilvl)
    }

}

