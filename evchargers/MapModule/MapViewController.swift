//
//  MapViewController.swift
//  evchargers
//
//  Created by John on 10/11/2019.
//  Copyright © 2019 John. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class MapViewController : UIViewController {
    var presenter : MapPresenter?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.notifyViewWillAppear()
    }
}

extension MapViewController : MapViewInterface {
    func setupInitialView(){
        let initialLocation = CLLocationCoordinate2D(latitude: 53, longitude: -8)
        let regionRadius: CLLocationDistance = 300000
        let coordinateRegion = MKCoordinateRegion(center: initialLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setCenter(initialLocation, animated: false)
    }
    
    func showLoading(){
        
    }
    
    func hideLoading(){
        
    }
    
    func setScreenTitle(with title:String){
        self.title = title
    }
    
    func drawChargeLocations(){
        guard let locationViewModels = presenter?.getLocationViewModels() else {
            return
        }
        for location in locationViewModels {
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            annotation.coordinate = location.coordinate
            mapView.addAnnotation(annotation)
        }
    }
}

