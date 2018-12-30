//
//  MapViewController.swift
//  evchargers
//
//  Created by John on 30/12/2018.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import AFNetworking

class MapViewController: UIViewController {
    
    var mapView : GMSMapView?
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 53, longitude: -8, zoom: 6.5)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        self.loadChargeLocations()
    }
    
    func loadChargeLocations(){
        var baseURL : URL
        if let bundleDict = Bundle.main.infoDictionary,
            let url = bundleDict["API_URL" as String] as? String {
            baseURL = URL.init(string: url)!
            let manager = AFHTTPSessionManager.init(baseURL: baseURL)
            manager.get("charger",
                        parameters: nil,
                        progress: nil,
                        success: {(operation, responseObject) in
                            if let responseArray : [Any] = responseObject as? [Any] {
                                self.drawChargeLocations(locations: responseArray)
                            }
            },
                        failure: {(operation, error) in
                            
            })
        }
    }
    
    func drawChargeLocations(locations : [Any]){
        if let locationDict = locations as? [[String:Any]] {
            for location in locationDict {
                let coords = location["coordinates"] as! [String : Double]
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: coords["lat"]!, longitude: coords["lng"]!)
                marker.title = location["name"] as? String
                marker.map = mapView
            }
        }
    }
}
