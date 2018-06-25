//
//  ViewController.swift
//  WoWilvlChecker
//
//  Created by Henrik Gustavii on 04/06/2018.
//  Copyright © 2018 Aecasorg. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class ViewController: UIViewController {

    let realm = try! Realm()
    
    var apiKey = "pgje56uws25hmdw426agmrkjcz4zbhuc"
    var name = "belangel"
    var charRealm = "azjol-nerub"
//    var fields = "talents"
    
    var chars: Results<CharacterModel>?
    var tempChar = CharacterModelTemp()
    
    @IBOutlet weak var charsTableView: UITableView!
    
    @IBOutlet weak var searchInput: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadChars()
        
        charsTableView.dataSource = self
        
    }
    
    // MARK: - Buttons
    
    @IBAction func alamoResponseButtonPressed(_ sender: Any) {
        print("*******************************")
        if let searchText = searchInput.text {
            
            
            
            var blizzardURL = urlCreator(name: searchText, realm: charRealm, fields: "items")
            getCharacterData(url: blizzardURL, dataChoice: 0) {(success) -> Void in
                
                blizzardURL = self.urlCreator(name: searchText, realm: self.charRealm, fields: "talents")
                self.getCharacterData(url: blizzardURL, dataChoice: 1) {(success) -> Void in
                    
                    blizzardURL = self.urlCreator(name: searchText, realm: self.charRealm, fields: "audit")
                    self.getCharacterData(url: blizzardURL, dataChoice: 2, completion: {(success) -> Void in
                        
                        let newChar = CharacterModel()
                        
                        newChar.charName = self.tempChar.charName
                        newChar.charRealm = self.tempChar.charRealm
                        newChar.lastModified = self.tempChar.lastModified
                        newChar.charClass = self.tempChar.charClass
                        newChar.thumbnail = self.tempChar.thumbnail
                        newChar.averageItemLevelEquipped = self.tempChar.averageItemLevelEquipped
                        newChar.neckEnchant = self.tempChar.neckEnchant
                        newChar.backEnchant = self.tempChar.backEnchant
                        newChar.finger1Enchant = self.tempChar.finger1Enchant
                        newChar.finger2Enchant = self.tempChar.finger2Enchant
                        newChar.spec = self.tempChar.spec
                        newChar.role = self.tempChar.role
                        newChar.emptySockets = self.tempChar.emptySockets
                        
                        self.save(character: newChar)})
                }
            }
        }
    }
    
    @IBAction func printCharButtonPressed(_ sender: Any) {
        printLastDataFetch()
    }

    //MARK: - Networking
    
    func getCharacterData(url: String, dataChoice: Int, completion: @escaping (_ success: Bool) -> Void) {

        // Passing the data collected from the character search we use Alamofire to get the JSON data
        Alamofire.request(url).responseJSON { response in
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
                
                completion(true)
                
            } else {
                print("Error \(String(describing: response.result.error))")
                completion(false)
            }

        }

    }
    
    func urlCreator(name: String, realm: String, fields: String) -> String {
        
        return "https://eu.api.battle.net/wow/character/\(realm)/\(name)?fields=\(fields)&locale=en_GB&apikey=\(apiKey)"
        
    }
    
    // MARK: - Data extraction
    
    func printData(data: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(CharacterModelItems.self, from: data)
//            print(decoded)
            
           
            tempChar.charName = decoded.name
            tempChar.charRealm = decoded.realm
            print("Character Name: " + decoded.name)
            print("Character Realm: " + decoded.realm)
            print("Character last modified: \(decoded.lastModified)")
            tempChar.lastModified = decoded.lastModified
            print("Character Class: \(classConverter(class: decoded.class))")
            tempChar.charClass = decoded.class
            print("Character Avatar: " + decoded.thumbnail)
            tempChar.thumbnail = decoded.thumbnail
            print("Character ilvl: \(decoded.items.averageItemLevelEquipped)")
            tempChar.averageItemLevelEquipped = decoded.items.averageItemLevelEquipped
            
            if let neck = decoded.items.neck.tooltipParams.enchant {
                print("Neck enchant: \(neck)")
                tempChar.neckEnchant = true
            } else {
                print("No neck enchant!")
            }
            
            if let back = decoded.items.back.tooltipParams.enchant {
                print("Back enchant: \(back)")
                tempChar.backEnchant = true
            } else {
                print("No back enchant!")
            }
            
            if let finger1 = decoded.items.finger1.tooltipParams.enchant {
                print("Ring1 enchant: \(finger1)")
                tempChar.finger1Enchant = true
            } else {
                print("No Ring1 enchant!")
            }
            
            if let finger2 = decoded.items.finger2.tooltipParams.enchant {
                print("Ring2 enchant: \(finger2)")
                tempChar.finger2Enchant = true
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
                tempChar.spec = decoded.talents[0].spec!.name
                print("Character role: \(decoded.talents[0].spec!.role)")
                tempChar.role = decoded.talents[0].spec!.role
            } else if decoded.talents[1].selected ?? false {
                print("Character talents: \(decoded.talents[1].spec!.name)")
                tempChar.spec = decoded.talents[1].spec!.name
                print("Character role: \(decoded.talents[1].spec!.role)")
                tempChar.role = decoded.talents[1].spec!.role
            } else if decoded.talents[2].selected ?? false {
                print("Character talents: \(decoded.talents[2].spec!.name)")
                tempChar.spec = decoded.talents[2].spec!.name
                print("Character role: \(decoded.talents[2].spec!.role)")
                tempChar.role = decoded.talents[2].spec!.role
            } else if decoded.talents[3].selected ?? false {
                print("Character talents: \(decoded.talents[3].spec!.name)")
                tempChar.spec = decoded.talents[3].spec!.name
                print("Character role: \(decoded.talents[3].spec!.role)")
                tempChar.role = decoded.talents[3].spec!.role
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
            tempChar.emptySockets = decoded.audit.emptySockets
            
//            print("Character unenchanted items: \(decoded.audit.unenchantedItems)")
        } catch {
            print("Failed to decode JSON")
        }
        
    }
    
    // MARK: - Helper functions
    
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
    
    func printLastDataFetch() {
        print("*****************")
        print("Name: \(chars?.last?.charName ?? "None")")
        print("Realm: \(chars?.last?.charRealm ?? "None")")
        print("ilvl: \(chars?.last?.averageItemLevelEquipped ?? 0)")
        print("Class: \(classConverter(class: (chars!.last?.charClass)!) )")
        print("Spec: \(chars?.last?.spec ?? "None")")
        print("Role: \(chars?.last?.role ?? "None")")
        print("Neck enchant?: \(chars?.last?.neckEnchant ?? false)")
        print("Back enchant?: \(chars?.last?.backEnchant ?? false)")
        print("Ring1 enchant?: \(chars?.last?.finger1Enchant ?? false)")
        print("Ring2 enchant?: \(chars?.last?.finger2Enchant ?? false)")
        print("Gems missing?: \(chars?.last?.emptySockets ?? 0)")
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(character: CharacterModel) {
        
        do {
            
            try realm.write {
                realm.add(character)
            }
        } catch {
            print("Error saving character \(error)")
        }
        
        self.charsTableView.reloadData()
        
    }
    
    func loadChars() {
        
        chars = realm.objects(CharacterModel.self)
        
        charsTableView.reloadData()
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - TableView Datasource Methods
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        print(chars?.count)
        return chars?.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CharacterTableViewCell
        
        if let char = chars?[indexPath.row] {
            
            cell.characterDataLabel.text = "\(char.charName) - iLevel: \(char.averageItemLevelEquipped)\n\(classConverter(class: (char.charClass))) - \(char.spec) (\(char.role))\nMissing gems: \(char.emptySockets)\nEnchants: \(char.backEnchant)"
            
//            guard let categoryColour = UIColor(hexString: charsList.bgColour) else { fatalError() }
//
//            cell.backgroundColor = categoryColour
//
//            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
            
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        performSegue(withIdentifier: "goToItems", sender: self)
//
//    }
    
}
