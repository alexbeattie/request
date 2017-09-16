//
//  ViewController.swift
//  avenue
//
//  Created by Alex Beattie on 9/14/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var labelTest: UILabel!
    var listings = [[String: String]]()

    let URL_LOCAL = "http://localhost:8888/simplyrets/file.js"

//    var listingDataModel = ListingDataModel()

    var address:String?
    var remarks:String?
    var listPrice: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        Alamofire.request(URL_LOCAL, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                
                let json : JSON = JSON(value)
//                print(self.listings)
                
//                if let theSales = json[0]["sales"]["closeDate"] {
//                 print (theSales)
//                }
//
                if let info = json.arrayObject{
//                    print ("The fucking json \(info)")
//                    if let sales = json[0]["sales"]["closeDate"] {
////                        print(self.labelTest)
//                    }
//                    let sales = info["sales"]["closeDate"] as? Dictionary<String,AnyObject>
//                    print(info)
//                    if let sales = info["sales"]["closeDate"] {
//                        print (sales)
                
                    //Address
//                    let address = json[0]["address"]["streetName"]["city"]["state"]["postalCode"]
                    
                    
//                    if let streetNumberText = json[1]["address"]["streetNumberText"].string,
//                     let streetName = json[13]["address"]["streetName"].string?.capitalized,
//                     let city = json[1]["address"]["city"].string,
//                     let state = json[1]["address"]["state"].string,
//                     let postalCode = json[1]["address"]["postalCode"].string {
////                        print("The state name is \(postalCode)")
//                        print ("The address is \(streetNumberText) \(streetName) \(city) \(state) \(postalCode)")
//
//                                    }
                    
//                  // Address/
                    guard let full = json[1]["address"]["full"].string?.capitalized else { return }
                        print(full)
      
                    //Photos
                    let photos = json[2]["photos"].arrayValue.map({$0.stringValue})
                        print(photos)
               
                    //Bedrooms
                    if let propertyBedrooms = json[0]["property"]["bedrooms"].int,
                        let propertyBathrooms = json[0]["property"]["bathsFull"].int {
                        print("There are \(propertyBedrooms) bedrooms & \(propertyBathrooms) bathrooms")
                    }
                    
                    //Coords
                    let coordlat = json[0]["geo"]["lat"].floatValue
                    let coordslon = json[0]["geo"]["lng"].floatValue
                        print("The coordinates are \(coordlat),\(coordslon)")
                  
                    //Price
                    if let listPrice = json[0]["listPrice"].number  {
                        let largeNumber = listPrice
                        let numberFormatter = NumberFormatter()
                        numberFormatter.numberStyle = NumberFormatter.Style.decimal
                        
                        if let formattedNumber = numberFormatter.string(from: (largeNumber)) {
                                print("$\(formattedNumber)")
                        }
                    }
                    
                    if let mlsId = json[0]["mlsId"].int {
                        print("The mlsId is \(mlsId)")
                    }
             

                

            
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
 


//Alamofire.request(URL_LOCAL, method: .get).validate().responseJSON { (response) in
//    switch response.result {
//    case .success(let value):
//
//        let json : JSON = JSON(value)
//        print(json)
//        if let name = json[0]["disclaimer"].string {
//            print(name)
//        }
//        if let agreement = json[0]["listDate"].string {
//            print(agreement)
//        }
//        if let id = json[0]["property"]["bathsFull"].int {
//            //Do something you want
//            print(id)
//        }
//    case .failure(let error):
//        print(error)
//    }
//}





//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    Alamofire.request(URL_LOCAL, method: .get).validate().responseJSON { (response) in
//        if response.result.isSuccess {
//
//            let json : JSON = JSON(response.result.value!)
//            if let name = json[0]["disclaimer"].string {
//                print(name)
//            }
//            if let agreement = json[0]["listDate"].string {
//                print(agreement)
//            }
//            if let id = json[0]["property"]["bathsFull"].int {
//                //Do something you want
//                print(id)
//            }
//        }
//        else {
//
//        }
//    }
//}








extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

