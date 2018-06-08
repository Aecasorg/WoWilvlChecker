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
                if let json = response.result.value {
                    print("JSON: \(json)")
                }

//                let weatherJSON: JSON = JSON(response.result.value!)
//                self.updateWeatherData(json: weatherJSON)
                
            } else {

                print("Error \(String(describing: response.result.error))")
//                self.cityLabel.text = "Connection Issues"

            }

        }

    }

}

