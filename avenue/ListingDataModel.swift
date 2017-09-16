//
//  ListingDataModel.swift
//  avenue
//
//  Created by Alex Beattie on 9/15/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import Foundation

struct ListingDataModel {
    var address:String?
    var remarks:String?
    var listPrice:Int?
    
    init(address: String, remarks:String, listPrice:Int) {
        self.address = address
        self.remarks = remarks
        self.listPrice = listPrice
    }
}
