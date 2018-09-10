//
//  SyntaxSelectViewController.swift
//  PasteBin
//
//  Created by Henrik Gustavii on 22/03/2018.
//  Copyright © 2018 JonLuca De Caro. All rights reserved.
//

import UIKit
import SearchTextField

class RealmSelectViewController: UIViewController {

    let realms = RealmLibraries().euRealms
//    let languages = SyntaxLibraries().languages

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var realmPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
//    @IBOutlet weak var searchSyntaxTextField: SearchTextField!
    @IBOutlet weak var searchRealmTextField: SearchTextField!
    
    
    var realm: String = ""
    var realmIndex: Int = 0
//    var syntax: String = ""
//    var syntaxIndex: Int = 0

    // Function type that can be accessed from Callback VC (ViewController.swift)
    var onSave: ((_ data: String, _ index: Int) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        realmPicker.delegate = self
        realmPicker.dataSource = self
        titleLabel.text = realm
        realmPicker.selectRow(realmIndex, inComponent: 0, animated: true)
        
        // SearchTextField settings
        searchRealmTextField.filterStrings(realms)
//        searchSyntaxTextField.theme = SearchTextFieldTheme.darkTheme()
        searchRealmTextField.theme.bgColor = UIColor (red: 160/255, green: 162/255, blue: 164/255, alpha: 0.95)
        searchRealmTextField.theme.fontColor = UIColor.white
        searchRealmTextField.maxNumberOfResults = 5
        searchRealmTextField.maxResultsListHeight = 180
//        searchSyntaxTextField.highlightAttributes = [kCTBackgroundColorAttributeName: UIColor(red: 181/255, green: 130/255, blue: 79/255, alpha: 1), kCTFontAttributeName: UIFont.boldSystemFont(ofSize: 12)] as [NSAttributedStringKey : AnyObject]
        
        // Handles what happens when user picks an item
        searchRealmTextField.itemSelectionHandler = { item, itemPosition in
            let item = item[itemPosition]
            self.searchRealmTextField.text = item.title
            self.realm = item.title
            
            if self.realms.contains(self.realm) {
                self.realmIndex = self.realms.index(of: self.realm)!
                self.realmPicker.selectRow(self.realmIndex, inComponent: 0, animated: true)
                self.titleLabel.text = self.realms[self.realmIndex]
            }
        }
    }
    
    // Sends realm choice to main VC and dismisses popup
    @IBAction func saveRealm_TouchUpInside(_ sender: UIButton) {
        
        onSave?(realm, realmIndex)
        
        dismiss(animated: true)
    }
    
    @IBAction func backPress(_ sender: UIButton) {
        
        dismiss(animated: true)
        
    }
    
    // Makes keyboard disappear by touching outside popup keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// UIPickerView setup
extension RealmSelectViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return realms.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        titleLabel.text = realms[row]
        realm = realms[row]
        realmIndex = row
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = realms[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.white])
        return myTitle
    }
    
}
