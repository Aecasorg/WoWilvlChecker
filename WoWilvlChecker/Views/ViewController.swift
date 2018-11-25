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

class ViewController: UIViewController, UISearchBarDelegate {

    let realm = try! Realm()
    
    let apiKey = "pgje56uws25hmdw426agmrkjcz4zbhuc" // Mashery API Blizz key
//    let apiToken = "USxRPkl7xFRWdb7H7BIUyuBm8IF7oLc4Ag" // New Blizz API key
    var name = "Belangel"
    var charRealm = ""
    var region = ""
    var charRealmIndex = 0
    
    // If true then character data download from Blizzard server has been successful
    var apiCheckSuccessful = true
    var validationCheckSuccessful = true
    
    var chars: Results<CharacterModel>?
    var tempChar = CharacterModelTemp()
    
    @IBOutlet weak var charsTableView: UITableView!
    @IBOutlet weak var searchInput: UISearchBar!
    @IBOutlet weak var realmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchInput.delegate = self
        
        loadChars()
        
        charsTableView.dataSource = self
        charsTableView.delegate = self
        
        hideKeyboardWhenTappedAround()
        
        if (UserDefaults.standard.string(forKey: "region") == nil) {
            UserDefaults.standard.set("eu", forKey: "region")
        }
        
        if (UserDefaults.standard.string(forKey: "realm") == nil) {
            UserDefaults.standard.set("Azjol-Nerub", forKey: "realm")
        }
        
        region = UserDefaults.standard.string(forKey: "region") ?? "eu"
        charRealm = UserDefaults.standard.string(forKey: "realm") ?? "Azjol-Nerub"
        
        searchInput.placeholder = "Search on \(charRealm)"
        
        print(region)
        print(charRealm)
        
        // Enables character lookup in Safari if character cell is long pressed
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(_:)))
        longPressGesture.minimumPressDuration = 1.2 // 1 second press
        charsTableView.addGestureRecognizer(longPressGesture)
        
    }
    
    // MARK: - Buttons
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        
        if let searchCharName = searchInput.text {
            
            downloadChar(charName: searchCharName)
        }
        
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar == searchInput {
            print("SearchBar touched!")
        }
    }
    
    @IBAction func realmButton(_ sender: UIButton) {
        print("realmButton touched!")
        
        let sb = UIStoryboard(name: "RealmSelectViewController", bundle: nil)
        let popup = sb.instantiateInitialViewController()! as! RealmSelectViewController
        popup.realm = charRealm
        popup.realmIndex = charRealmIndex
        popup.region = region
        present(popup, animated: true)
        
        // Callback closure to fetch data from popup
        popup.onSave = { (data, index, region) in
            self.charRealm = data
            self.charRealmIndex = index
            self.region = region
            print("CharRealm is -\(self.charRealm) and region is \(self.region)-")
            UserDefaults.standard.set(region, forKey: "region")
            UserDefaults.standard.set(data, forKey: "realm")
            
            self.searchInput.placeholder = "Search on \(self.charRealm)"
        }
        
    }
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.charsTableView)
            if let indexPath = charsTableView.indexPathForRow(at: touchPoint) {
                
                    guard var url = URL(string: "https://worldofwarcraft.com") else {
                        print("Not able to assign URL to url var")
                        return //be safe
                    }
                    if let char = chars?.reversed()[indexPath.row] {
            
                        let editedCharRealm = char.charRealm.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "'", with: "")
            
                        let urlString = "https://worldofwarcraft.com/en-gb/character/\(editedCharRealm)/\(char.charName)".lowercased()
            
                        url = URL(string: urlString )!
                    }
                    UIApplication.shared.open(url, options: [:])
                    print(url)
                
            }
        }
    }
    
    //MARK: - API/JSON data handling
    func downloadChar(charName: String) {
        apiCheckSuccessful = true
        validationCheckSuccessful = true
        
        var blizzardURL = urlCreator(name: charName, realm: charRealm, fields: "items")
        getCharacterData(url: blizzardURL, dataChoice: 0) {(success) -> Void in
            
            blizzardURL = self.urlCreator(name: charName, realm: self.charRealm, fields: "talents")
            self.getCharacterData(url: blizzardURL, dataChoice: 1) {(success) -> Void in
                
                blizzardURL = self.urlCreator(name: charName, realm: self.charRealm, fields: "audit")
                self.getCharacterData(url: blizzardURL, dataChoice: 2, completion: {(success) -> Void in
                    
                    if self.apiCheckSuccessful && self.validationCheckSuccessful {
                        let newChar = CharacterModel()
                        
                        
                        newChar.charName = self.tempChar.charName
                        newChar.charRealm = self.tempChar.charRealm
                        newChar.lastModified = self.tempChar.lastModified
                        newChar.charClass = self.tempChar.charClass
                        newChar.thumbnail = self.tempChar.thumbnail
                        newChar.averageItemLevelEquipped = self.tempChar.averageItemLevelEquipped
                        newChar.neckLevel = self.tempChar.neckLevel
                        newChar.spec = self.tempChar.spec
                        newChar.role = self.tempChar.role
                        newChar.emptySockets = self.tempChar.emptySockets
                        newChar.numberOfGems = self.tempChar.numberOfGems
                        newChar.numberOfEnchants = self.tempChar.numberOfEnchants
                        newChar.totalNumberOfEnchants = self.tempChar.totalNumberOfEnchants
                        
                        self.save(character: newChar)
                    }
                })
            }
        }
    }
    
    func updateChar(charName: String, charID: String, charRealm: String, indexPath: IndexPath) {
        apiCheckSuccessful = true
        print("**** Updating: \(charName) at \(indexPath) ****")
        
        var blizzardURL = urlCreator(name: charName, realm: charRealm, fields: "items")
        getCharacterData(url: blizzardURL, dataChoice: 0) {(success) -> Void in
            
            blizzardURL = self.urlCreator(name: charName, realm: charRealm, fields: "talents")
            self.getCharacterData(url: blizzardURL, dataChoice: 1) {(success) -> Void in
                
                blizzardURL = self.urlCreator(name: charName, realm: charRealm, fields: "audit")
                self.getCharacterData(url: blizzardURL, dataChoice: 2, completion: {(success) -> Void in
                    
                    if self.apiCheckSuccessful {
                        let newChar = CharacterModel()
                        
                        newChar.charID = charID
                        newChar.charName = self.tempChar.charName
                        newChar.charRealm = self.tempChar.charRealm
                        newChar.lastModified = self.tempChar.lastModified
                        newChar.charClass = self.tempChar.charClass
                        newChar.thumbnail = self.tempChar.thumbnail
                        newChar.averageItemLevelEquipped = self.tempChar.averageItemLevelEquipped
                        newChar.neckLevel = self.tempChar.neckLevel
                        newChar.spec = self.tempChar.spec
                        newChar.role = self.tempChar.role
                        newChar.emptySockets = self.tempChar.emptySockets
                        newChar.numberOfGems = self.tempChar.numberOfGems
                        newChar.numberOfEnchants = self.tempChar.numberOfEnchants
                        newChar.totalNumberOfEnchants = self.tempChar.totalNumberOfEnchants
                        
                        self.update(character: newChar, indexPath: indexPath)
                    }
                })
            }
        }
    }
    
    func urlCreator(name: String, realm: String, fields: String) -> String {
        
        return "https://\(region).api.battle.net/wow/character/\(realm)/\(name)?fields=\(fields)&apikey=\(apiKey)" // Mashery Blizzard API
//        return "https://\(region).api.blizzard.com/wow/character/\(realm)/\(name)?fields=\(fields)&access_token=\(apiToken)" // New Blizzard API
        
    }

    //MARK: - Networking
    
    func getCharacterData(url: String, dataChoice: Int, completion: @escaping (_ success: Bool) -> Void) {

        // Passing the data collected from the character search we use Alamofire to get the JSON data
        Alamofire.request(url).validate().responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")
            
            switch response.result {
            case .success:
                
                print("---- Validation Successful! ----")

                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                    print("Data: \(utf8Text)") // original server data as UTF8 string

                    if dataChoice == 0 {
                        self.printDataItems(data: data)
                    } else if dataChoice == 1 {
                        self.printDataTalents(data: data)
                    } else {
                        self.printDataAudit(data: data)
                    }

                }

                completion(true)
                
            case .failure(let error):
                
                print("Error: \(error)")
                
                let alert = UIAlertController(title: "Character not found!", message: "Make sure you have the correct spelling and/or realm", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                
                self.validationCheckSuccessful = false
                
                completion(false)
                
            }

        }

    }
    
    // MARK: - Data extraction
    
    func printDataItems(data: Data) {
        
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
            
            tempChar.neckLevel = decoded.items.neck.azeriteItem?.azeriteLevel ?? 0
            
            var numberOfEnchants: Int = 0
            var totalNumberOfEnchants: Int = 3
            
            numberOfEnchants += decoded.items.finger1.tooltipParams.enchant != nil ? 1 : 0
            numberOfEnchants += decoded.items.finger2.tooltipParams.enchant != nil ? 1 : 0
            numberOfEnchants += decoded.items.mainHand.tooltipParams.enchant != nil ? 1 : 0
            
            if decoded.items.offHand?.tooltipParams.enchant != nil {
                numberOfEnchants += 1
                totalNumberOfEnchants += 1
            } else if decoded.items.offHand?.weaponInfo != nil {
                totalNumberOfEnchants += 1
            }
            
            tempChar.numberOfEnchants = numberOfEnchants
            tempChar.totalNumberOfEnchants = totalNumberOfEnchants
            print("Enchants: \(numberOfEnchants)/\(totalNumberOfEnchants)")
            
            var numberOfGems: Int = 0
            
            numberOfGems += decoded.items.back.tooltipParams.gem0 != nil ? 1 : 0
            numberOfGems += decoded.items.wrist.tooltipParams.gem0 != nil ? 1 : 0
            numberOfGems += decoded.items.hands.tooltipParams.gem0 != nil ? 1 : 0
            numberOfGems += decoded.items.waist.tooltipParams.gem0 != nil ? 1 : 0
            numberOfGems += decoded.items.legs.tooltipParams.gem0 != nil ? 1 : 0
            numberOfGems += decoded.items.feet.tooltipParams.gem0 != nil ? 1 : 0
            numberOfGems += decoded.items.finger1.tooltipParams.gem0 != nil ? 1 : 0
            numberOfGems += decoded.items.finger2.tooltipParams.gem0 != nil ? 1 : 0
            numberOfGems += decoded.items.trinket1.tooltipParams.gem0 != nil ? 1 : 0
            numberOfGems += decoded.items.trinket2.tooltipParams.gem0 != nil ? 1 : 0
            numberOfGems += decoded.items.mainHand.tooltipParams.gem0 != nil ? 1 : 0
            numberOfGems += decoded.items.offHand?.tooltipParams.gem0 != nil ? 1 : 0
            
            tempChar.numberOfGems = numberOfGems
            print("Number of gems: \(tempChar.numberOfGems)")
            
        } catch {
            print("Failed to decode JSON: \(error)")
            apiCheckSuccessful = false
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
            apiCheckSuccessful = false
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
            apiCheckSuccessful = false
        }
        
    }
    
    // MARK: - Library functions
    
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
    
    func classColor(class: Int) -> Int {
        switch `class` {
        case 1:
            return 0xC79C6E
        case 2:
            return 0xF58CBA
        case 3:
            return 0xABD473
        case 4:
            return 0xFFF569
        case 5:
            return 0xFFFFFF
        case 6:
            return 0xC41F3B
        case 7:
            return 0x0070DE
        case 8:
            return 0x69CCF0
        case 9:
            return 0x9482C9
        case 10:
            return 0x00FF96
        case 11:
            return 0xFF7D0A
        case 12:
            return 0xA330C9
        default:
            return 0x000000
        }
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
    
    func update(character: CharacterModel, indexPath: IndexPath) {
        
        do {
            
            try realm.write {
                realm.add(character, update: true)
            }
        } catch {
            print("Error updating character \(error)")
        }
        
//        self.charsTableView.reloadRows(at: [indexPath], with: .automatic)
        print("Rows after update: \(String(describing: chars?.count))")
        charsTableView.reloadData()
        
    }

}

// MARK: - Extensions

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - TableView Datasource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        print(chars?.count)
        return chars?.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CharacterTableViewCell
        
        if let char = chars?.reversed()[indexPath.row] {

            let formattedString = NSMutableAttributedString()

            formattedString
                .normal("\(char.charName) - \(char.charRealm)\n\(classConverter(class: (char.charClass))) - \(char.spec) (\(char.role))\niLevel: ")
                .bold("\(char.averageItemLevelEquipped)")
                .normal(" - Neck: ")
                .bold("\(char.neckLevel)")
                .normal("\nGems: ")
                .bold("\((char.numberOfGems + char.emptySockets) - char.emptySockets)/\(char.numberOfGems + char.emptySockets)")
                .normal("\nEnchants: ")
                .bold("\(char.numberOfEnchants)/\(char.totalNumberOfEnchants)")

            cell.characterDataLabel.attributedText = formattedString

            cell.characterThumbnail.downloadedFrom(link: "http://render-eu.worldofwarcraft.com/character/\(char.thumbnail)")

            cell.characterBackground.backgroundColor = UIColor(hex: classColor(class: char.charClass))
            
            cell.setupCell()

        }

        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionedPerformed: (Bool) -> Void) in
            self.deleteCharacter(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            actionedPerformed(true) // Makes swipe disappear after action
        }
        
        delete.image = UIImage(named: "delete-icon")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let refresh = UIContextualAction(style: .normal, title: "Refresh") { (contextualAction, view, actionedPerformed: (Bool) -> Void) in
            self.updateChar(charName: self.chars!.reversed()[indexPath.row].charName, charID: self.chars!.reversed()[indexPath.row].charID, charRealm: self.chars!.reversed()[indexPath.row].charRealm, indexPath: indexPath)
            actionedPerformed(true) // Makes swipe disappear after action
        }
        
        refresh.image = UIImage(named: "reload-icon")
        refresh.backgroundColor = #colorLiteral(red: 0.3006752524, green: 0.461567281, blue: 1, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [refresh])
        
    }
    
    // Delete character when swiping
    func deleteCharacter(at indexPath: IndexPath) {
        // Update our data model
        print("Deleting index...")
        
        if let charForDeletion = self.chars?.reversed()[indexPath.row] {
            print("**** Deleting: \(charForDeletion.charName)")
            do {
                try self.realm.write {
                    self.realm.delete(charForDeletion)
                }
            } catch {
                print("Error deleting category \(error)")
            }
        }
    }
}


