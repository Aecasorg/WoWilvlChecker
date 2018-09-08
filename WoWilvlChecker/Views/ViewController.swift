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
import SwipeCellKit

class ViewController: UIViewController, UISearchBarDelegate {

    let realm = try! Realm()
    
    var apiKey = "pgje56uws25hmdw426agmrkjcz4zbhuc"
    var name = "belangel"
    var charRealm = "azjol-nerub"
    var apiCheck = true
    
    var chars: Results<CharacterModel>?
    var tempChar = CharacterModelTemp()
    
    // used to temporarily store lastModified data field and indexPath on stored character
//    var existingLastModified = 0
//    var indexPathToBeUpdated: IndexPath = []
    
    @IBOutlet weak var charsTableView: UITableView!
    
    @IBOutlet weak var searchInput: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchInput.delegate = self
        
        loadChars()
        
        charsTableView.dataSource = self
        
        self.hideKeyboardWhenTappedAround()
        
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
    
    func downloadChar(charName: String) {
        apiCheck = true
        
        var blizzardURL = urlCreator(name: charName, realm: charRealm, fields: "items")
        getCharacterData(url: blizzardURL, dataChoice: 0) {(success) -> Void in
            
            blizzardURL = self.urlCreator(name: charName, realm: self.charRealm, fields: "talents")
            self.getCharacterData(url: blizzardURL, dataChoice: 1) {(success) -> Void in
                
                blizzardURL = self.urlCreator(name: charName, realm: self.charRealm, fields: "audit")
                self.getCharacterData(url: blizzardURL, dataChoice: 2, completion: {(success) -> Void in
                    
                    if self.apiCheck {
                        let newChar = CharacterModel()
                        
                        
                        newChar.charName = self.tempChar.charName
                        newChar.charRealm = self.tempChar.charRealm
                        newChar.lastModified = self.tempChar.lastModified
                        newChar.charClass = self.tempChar.charClass
                        newChar.thumbnail = self.tempChar.thumbnail
                        newChar.averageItemLevelEquipped = self.tempChar.averageItemLevelEquipped
//                        newChar.neckEnchant = self.tempChar.neckEnchant
//                        newChar.backEnchant = self.tempChar.backEnchant
                        newChar.finger1Enchant = self.tempChar.finger1Enchant
                        newChar.finger2Enchant = self.tempChar.finger2Enchant
                        newChar.mainHandEnchant = self.tempChar.mainHandEnchant
                        newChar.spec = self.tempChar.spec
                        newChar.role = self.tempChar.role
                        newChar.emptySockets = self.tempChar.emptySockets
                        newChar.numberOfEnchants = self.tempChar.numberOfEnchants
                        
                        self.save(character: newChar)
                    }
                })
            }
        }
    }
    
    func updateChar(charName: String, charID: String, indexPath: IndexPath) {
        apiCheck = true
        print("**** Updating: \(charName) at \(indexPath) ****")
        
        var blizzardURL = urlCreator(name: charName, realm: charRealm, fields: "items")
        getCharacterData(url: blizzardURL, dataChoice: 0) {(success) -> Void in
            
            blizzardURL = self.urlCreator(name: charName, realm: self.charRealm, fields: "talents")
            self.getCharacterData(url: blizzardURL, dataChoice: 1) {(success) -> Void in
                
                blizzardURL = self.urlCreator(name: charName, realm: self.charRealm, fields: "audit")
                self.getCharacterData(url: blizzardURL, dataChoice: 2, completion: {(success) -> Void in
                    
                    if self.apiCheck {
                        let newChar = CharacterModel()
                        
                        newChar.charID = charID
                        newChar.charName = self.tempChar.charName
                        newChar.charRealm = self.tempChar.charRealm
                        newChar.lastModified = self.tempChar.lastModified
                        newChar.charClass = self.tempChar.charClass
                        newChar.thumbnail = self.tempChar.thumbnail
                        newChar.averageItemLevelEquipped = self.tempChar.averageItemLevelEquipped
//                        newChar.neckEnchant = self.tempChar.neckEnchant
//                        newChar.backEnchant = self.tempChar.backEnchant
                        newChar.finger1Enchant = self.tempChar.finger1Enchant
                        newChar.finger2Enchant = self.tempChar.finger2Enchant
                        newChar.mainHandEnchant = self.tempChar.mainHandEnchant
                        newChar.spec = self.tempChar.spec
                        newChar.role = self.tempChar.role
                        newChar.emptySockets = self.tempChar.emptySockets
                        newChar.numberOfEnchants = self.tempChar.numberOfEnchants
                        
                        self.update(character: newChar, indexPath: indexPath)
                    }
                })
            }
        }
    }
    
    func urlCreator(name: String, realm: String, fields: String) -> String {
        
        return "https://eu.api.battle.net/wow/character/\(realm)/\(name)?fields=\(fields)&locale=en_GB&apikey=\(apiKey)"
        
    }

    //MARK: - Networking
    
    func getCharacterData(url: String, dataChoice: Int, completion: @escaping (_ success: Bool) -> Void) {

        // Passing the data collected from the character search we use Alamofire to get the JSON data
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess {
                
                print("---- Success in getting data! ----")
                
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
            
//            if let neck = decoded.items.neck.tooltipParams.enchant {
//                print("Neck enchant: \(neck)")
//                tempChar.neckEnchant = true
//            } else {
//                print("No neck enchant!")
//            }
            
//            if let back = decoded.items.back.tooltipParams.enchant {
//                print("Back enchant: \(back)")
//                tempChar.backEnchant = true
//            } else {
//                print("No back enchant!")
//            }
            
            tempChar.finger1Enchant = false
            if let finger1 = decoded.items.finger1.tooltipParams.enchant {
                print("Ring1 enchant: \(finger1)")
                tempChar.finger1Enchant = true
            } else {
                print("No Ring1 enchant!")
            }
            
            tempChar.finger2Enchant = false
            if let finger2 = decoded.items.finger2.tooltipParams.enchant {
                print("Ring2 enchant: \(finger2)")
                tempChar.finger2Enchant = true
            } else {
                print("No Ring2 enchant!")
            }
            
            tempChar.mainHandEnchant = false
            if let mainHand = decoded.items.mainHand.tooltipParams.enchant {
                print("Main Hand enchant: \(mainHand)")
                tempChar.mainHandEnchant = true
            } else {
                print("No MainHand enchant!")
            }
            
            tempChar.numberOfEnchants = 0
            if tempChar.finger1Enchant { tempChar.numberOfEnchants += 1 }
            if tempChar.finger2Enchant { tempChar.numberOfEnchants += 1 }
            if tempChar.mainHandEnchant { tempChar.numberOfEnchants += 1 }
            
            print("Number of enchants: \(tempChar.numberOfEnchants)/3")
            
        } catch {
            print("Failed to decode JSON")
            apiCheck = false
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
            apiCheck = false
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
            apiCheck = false
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
        print("Rows after upadte: \(chars?.count)")
        charsTableView.reloadData()
        
    }

}

// MARK: - Extensions

extension ViewController: UITableViewDataSource, UITableViewDelegate, SwipeTableViewCellDelegate {
    
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
        
        cell.delegate = self
        
        if let char = chars?.reversed()[indexPath.row] {
            
            let formattedString = NSMutableAttributedString()
            
            formattedString
                .normal("\(char.charName) - \(char.charRealm)\n\(classConverter(class: (char.charClass))) - \(char.spec) (\(char.role))\niLevel: ")
                .bold("\(char.averageItemLevelEquipped)")
                .normal(" - Neck: ")
                .bold("16")
                .normal("\nMissing Gems: ")
                .bold("\(char.emptySockets)")
                .normal("\nEnchants: ")
                .bold("\(char.numberOfEnchants)/3")
            
//            formattedString
//                .normal("\(char.charName) - iLevel: ")
//                .bold("\(char.averageItemLevelEquipped)")
//                .normal("\n\(classConverter(class: (char.charClass))) - \(char.spec) (\(char.role))\nMissing gems: \(char.emptySockets)\nEnchants: \(char.backEnchant)")
            
            cell.characterDataLabel.attributedText = formattedString
            
            cell.characterThumbnail.layer.cornerRadius = 20
            cell.characterThumbnail.layer.masksToBounds = true
            
            cell.characterThumbnail.downloadedFrom(link: "http://render-eu.worldofwarcraft.com/character/\(char.thumbnail)")

            cell.characterBackground.backgroundColor = UIColor(hex: classColor(class: char.charClass))
            
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }

        // Delete character (swipe from right)
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            self.deleteCharacter(at: indexPath)
            action.fulfill(with: .delete)
        }
        
        deleteAction.image = UIImage(named: "delete-icon")
        
        // Update character (swipe from left)
        let updateAction = SwipeAction(style: .destructive, title: "Refresh") { action, indexPath in
            
            self.updateChar(charName: self.chars!.reversed()[indexPath.row].charName, charID: self.chars!.reversed()[indexPath.row].charID, indexPath: indexPath)
        }

        updateAction.image = UIImage(named: "reload-icon")

        return orientation == .right ? [deleteAction] : [updateAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive(automaticallyDelete: false)
        return options
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

// Deals with downloading thumbnail image
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
}

// Deals with converting hex colours for character class backgrounds
extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
}

// Deals with including bold text with within label text
extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 15)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}

// Dismisses keyboard when tapped anywhere else on screen
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
