//
//  MapPresenterTests.swift
//  evchargersTests
//
//  Created by John on 11/11/2019.
//  Copyright © 2019 John. All rights reserved.
//

import XCTest
import CoreLocation

class MapPresenterTests: XCTestCase {
    
    var presenter : MapPresenter?
    let mockInteractor = MockInteractor()
    let mockRouter = MockRouter()
    let mockView = MockView()
    
    let fakeLocations = [
        Location(name: "Name", address: "Address", coordinates: CLLocationCoordinate2D(latitude: 1, longitude: 1))
    ]
    
    class MockView : MapViewInterface {
        
        var initalViewSetup = false
        var chargeLocationsDrawn = false
        var loadingShown = false
        var loadingHidden = false
        var screenTitle : String?
        
        func setupInitialView() {
            initalViewSetup = true
        }
        
        func drawChargeLocations() {
            chargeLocationsDrawn = true
        }
        
        func showLoading() {
            loadingShown = true
        }
        
        func hideLoading() {
            loadingHidden = true
        }
        
        func setScreenTitle(with title: String) {
            screenTitle = title
        }
        
    }
    
    class MockInteractor : MapInteractorInterface {
        var locationsFetched = false
        func fetchLocations() {
            locationsFetched = true
        }
    }
    
    class MockRouter : MapRouterInterface {
        var errorMessage : String?
        var segueIdentifier : String?
        
        func performSegue(with identifier:String){
            segueIdentifier = identifier
        }
        func presentPopup(with message:String){
            errorMessage = message
        }
    }

    override func setUp() {
        super.setUp()
        presenter = MapPresenter()
        presenter?.interactor = mockInteractor
        presenter?.router = mockRouter
        presenter?.view = mockView
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNotifyViewLoaded() {
        presenter?.notifyViewLoaded()
        XCTAssertTrue(mockView.initalViewSetup)
        XCTAssertTrue(mockView.loadingShown)
        XCTAssertTrue(mockInteractor.locationsFetched)
    }
    
    func testNotifyViewWillAppear(){
        presenter?.notifyViewWillAppear()
        XCTAssertEqual(presenter?.pageTitle, mockView.screenTitle)
    }
    
    func testLocationsFetched(){
        presenter?.locationsFetched(locationList: fakeLocations)
        XCTAssertTrue(mockView.loadingHidden)
        XCTAssertTrue(mockView.chargeLocationsDrawn)
        XCTAssertEqual(presenter?.getLocationViewModels()?.count, 1)
    }
    

    func testLocationsFetchFailed(){
        let message = "Error Message"
        presenter?.locationsFetchFailed(with: message)
        XCTAssertEqual(mockRouter.errorMessage, message)
    }

}
