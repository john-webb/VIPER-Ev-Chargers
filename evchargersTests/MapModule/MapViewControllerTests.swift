//
//  evchargersTests.swift
//  evchargersTests
//
//  Created by John on 30/12/2018.
//  Copyright © 2018 John. All rights reserved.
//

import XCTest
import MapKit

class MapViewControllerTests : XCTestCase {
    
    
    class MockPresenter : MapPresenterInterface {
        var viewLoaded = false
        var viewWillAppear = false
        var selectedMarker = false
        var locationFetched = false
        var locationFailed = false
        var locationViewModels : [LocationViewModel]?
        
        func notifyViewLoaded() {
            viewLoaded = true
        }
        
        func notifyViewWillAppear() {
            viewWillAppear = true
        }
        
        func markerSelected() {
            selectedMarker = true
        }
        
        func getLocationViewModels() -> [LocationViewModel]? {
            return locationViewModels
        }
        
        
        func locationsFetched(locationList: [Location]) {
            locationFetched = true
        }
        
        func locationsFetchFailed(with errorMessage: String) {
            locationFailed = true
        }
        
        
    }
    
    var presenter = MockPresenter()
    var view : MapViewController?
    let mapView = MKMapView()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = MapViewController()
        view?.presenter = presenter
        view?.mapView = mapView
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoad() {
        view?.viewDidLoad()
        XCTAssertTrue(presenter.viewLoaded)
    }
    
    func testViewWillAppear(){
        view?.viewWillAppear(true)
        XCTAssertTrue(presenter.viewWillAppear)
    }
    
    func testScreenTitle(){
        let screenTitle = "Map"
        view?.setScreenTitle(with: screenTitle)
        XCTAssertEqual(view?.title, screenTitle)
    }
    
    func testDrawNoChargeLocations(){
        presenter.locationViewModels = nil
        view?.mapView.removeAnnotations(mapView.annotations)
        view?.drawChargeLocations()
        XCTAssertEqual(mapView.annotations.count, 0)
    }
    
    func testDrawChargeLocations(){
        presenter.locationViewModels = [
            (name: "Test", address: "", coordinate : CLLocationCoordinate2D(latitude: 0, longitude: 0))
        ]
        view?.mapView.removeAnnotations(mapView.annotations)
        view?.drawChargeLocations()
        XCTAssertEqual(mapView.annotations.count, 1)
    }
}
