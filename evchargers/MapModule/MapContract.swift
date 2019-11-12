//
//  MapContract.swift
//  evchargers
//
//  Created by John on 10/11/2019.
//  Copyright © 2019 John. All rights reserved.
//


// MapPresenter->MapView
protocol MapViewInterface : class{
    func setupInitialView()
    func drawChargeLocations()
    func showLoading()
    func hideLoading()
    func setScreenTitle(with title:String)
}


protocol MapPresenterInterface : class {
    // MapView->MapPresenter
    func notifyViewLoaded()
    func notifyViewWillAppear()
    func markerSelected()
    func getLocationViewModels() -> [LocationViewModel]?
    
    // MapInteractor -> MapPresenter
    func locationsFetched(locationList:[Location])
    func locationsFetchFailed(with errorMessage:String)
}

protocol MapRouterInterface : class {
    // MapPresenter -> MapRouter
    func performSegue(with identifier:String)
    func presentPopup(with message:String)
}

protocol MapInteractorInterface : class {
    // MapPresenter->MapInteractor
    func fetchLocations()
}
