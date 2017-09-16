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

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var imageOne: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getData()
        
     
}
 
    func getData() {
        Alamofire.request(URL_LOCAL, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                
                let json : JSON = JSON(value)
                
                if let info = json.arrayObject{
                    
                    // Address/
                    guard let full = json[1]["address"]["full"].string?.capitalized else { return }
                    print(full)
                        self.addressLbl.text = full
                    
                    //Photos
                    let photos = json[2]["photos"].arrayValue.map({$0.stringValue})
                    print(photos)
                        self.imageOne.image = UIImage(named: photos[0])
                    
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
                    //mlsId
                    if let mlsId = json[0]["mlsId"].int {
                        print("The mlsId is \(mlsId)")
                    }
                    print(info)
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

