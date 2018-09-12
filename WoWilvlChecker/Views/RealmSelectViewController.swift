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

    var realms = RealmLibraries().euRealms

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var realmPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var searchRealmTextField: SearchTextField!
    @IBOutlet weak var realmSelector: UISegmentedControl!
    
    var realm: String = ""
    var realmIndex: Int = 0
    var region: String = ""

    // Function type that can be accessed from Callback VC (ViewController.swift)
    var onSave: ((_ data: String, _ index: Int, _ region: String) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        realmPicker.delegate = self
        realmPicker.dataSource = self
        titleLabel.text = realm
        realmPicker.selectRow(realmIndex, inComponent: 0, animated: true)
        
        // SearchTextField settings
        searchRealmTextField.filterStrings(realms)
        searchRealmTextField.theme.bgColor = UIColor (red: 160/255, green: 162/255, blue: 164/255, alpha: 0.95)
        searchRealmTextField.theme.fontColor = UIColor.white
        searchRealmTextField.maxNumberOfResults = 5
        searchRealmTextField.maxResultsListHeight = 180
        
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
        
        
        realmSelector.selectedSegmentIndex = region == "us" ? 0 : 1
    }
    
    @IBAction func realmSelectorTouched(_ sender: UISegmentedControl) {
        
        switch realmSelector.selectedSegmentIndex
        {
        case 0:
            realms = RealmLibraries().usRealms
            region = "us"
        case 1:
            realms = RealmLibraries().euRealms
            region = "eu"
        default:
            break;
        }
    }
    
    // Sends realm choice to main VC and dismisses popup
    @IBAction func saveRealm_TouchUpInside(_ sender: UIButton) {
        
        onSave?(realm, realmIndex, region)
        
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

@IBDesignable
class RoundUIView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
