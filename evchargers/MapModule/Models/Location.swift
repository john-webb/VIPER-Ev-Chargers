//
//  Location.swift
//  evchargers
//
//  Created by John on 10/11/2019.
//  Copyright © 2019 John. All rights reserved.
//
import CoreLocation

class Location: NSObject {
    let name : String!
    let address : String?
    let coordinates : CLLocationCoordinate2D!
    
    init(name : String, address : String, coordinates : CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.coordinates = coordinates
    }
    
    init?(dict : [String: Any]){
        guard let name = dict["name"] as? String,
//            let address = dict["address"] as? String,
            let coordinates = dict["coordinates"] as? [String : Double],
            let lat = coordinates["lat"],
            let lng = coordinates["lng"] else
        {
            return nil
        }
        self.name = name
        self.address = ""
        self.coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}
