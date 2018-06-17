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
    var name = "belangel"
    var realm = "azjol-nerub"
//    var fields = "talents"
    
    
    @IBOutlet weak var searchInput: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchInput.showsScopeBar = true
//        searchInput.delegate
    }
    
    @IBAction func alamoResponseButtonPressed(_ sender: Any) {
        print("*******************************")
        if let searchText = searchInput.text {
            var blizzardURL = urlCreator(name: searchText, realm: realm, fields: "items")
            getCharacterData(url: blizzardURL, dataChoice: 0)
            blizzardURL = urlCreator(name: searchText, realm: realm, fields: "talents")
            getCharacterData(url: blizzardURL, dataChoice: 1)
            blizzardURL = urlCreator(name: searchText, realm: realm, fields: "audit")
            getCharacterData(url: blizzardURL, dataChoice: 2)
        }
    }

    //MARK: - Networking
    /***************************************************************/
    
    func getCharacterData(url: String, dataChoice: Int) {

        // Passing the data collected from the character search we use Alamofire to get the JSON data
        Alamofire.request(url).responseJSON {
            response in
            if response.result.isSuccess {

                print("Success!")
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                    print("Data: \(utf8Text)") // original server data as UTF8 string
                    if dataChoice == 0 {
                        self.printData(data: data)
                    } else if dataChoice == 1 {
                        self.printDataTalents(data: data)
                    } else {
                        self.printDataAudit(data: data)
                    }
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
//            print(decoded)
            print("Character last modified: \(decoded.lastModified)")
            print("Character Name: " + decoded.name)
            print("Character Realm: " + decoded.realm)
            print("Character Class: \(classConverter(class: decoded.class))")
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
                print("Ring1 enchant: \(finger1)")
            } else {
                print("No Ring1 enchant!")
            }
            
            if let finger2 = decoded.items.finger2.tooltipParams.enchant {
                print("Ring2 enchant: \(finger2)")
            } else {
                print("No Ring2 enchant!")
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
//            print("Character last modified: \(decoded.lastModified)")
//            print("Character Name: " + decoded.name)
//            print("Character Realm: " + decoded.realm)
//            print("Character Avatar: " + decoded.thumbnail)
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
//            print(decoded)
//            print("Character last modified: \(decoded.lastModified)")
//            print("Character Name: " + decoded.name)
//            print("Character Realm: " + decoded.realm)
//            print("Character Avatar: " + decoded.thumbnail)
            print("Character empty sockets: \(decoded.audit.emptySockets)")
//            print("Character unenchanted items: \(decoded.audit.unenchantedItems)")
        } catch {
            print("Failed to decode JSON")
        }
        
    }
    
    func classConverter(class: Int) -> String {
        switch `class` {
            case 1:
                return "Warrior"
            case 2:
                return "Paladin"
            case 3:
                return "Hunter"
            case 4:
                return "Rogue"
            case 5:
                return "Priest"
            case 6:
                return "Death Knight"
            case 7:
                return "Shaman"
            case 8:
                return "Mage"
            case 9:
                return "Warlock"
            case 10:
                return "Monk"
            case 11:
                return "Druid"
            case 12:
                return "Demon Hunter"
            default:
                return "Unknown"
        }
    }

}
