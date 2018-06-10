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

    let blizzardURL = "https://eu.api.battle.net/wow/character/azjol-nerub/annebelle?locale=en_GB&apikey="
    let apiKey = "pgje56uws25hmdw426agmrkjcz4zbhuc"
    
//    var data: Data
//    let decoder = JSONDecoder()
    
    @IBAction func alamoResponseButtonPressed(_ sender: Any) {
        getCharacterData(url: blizzardURL + apiKey)
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
//                self.cityLabel.text = "Connection Issues"

            }

        }

    }
    
    func printData(data: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(CharacterModel.self, from: data)
            print(decoded)
            print("Character Name: " + decoded.charName)
            print("Character Realm: " + decoded.charRealm)
            print("Character Avatar: " + decoded.charAvatar)
        } catch {
            print("Failed to decode JSON")
        }
        
    }

}

struct CharacterModel: Codable {
    
    var charName, charRealm, charAvatar: String
//    let charName, charRealm, charSpec, charAvatar: String
//    let charClass, charilvl, charEnchants, charGems: Int
    
    enum CodingKeys: String, CodingKey {
        case charName = "name"
        case charRealm = "realm"
        case charAvatar = "thumbnail"
    }

}

