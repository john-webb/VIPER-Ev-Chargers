//
//  MapPresenter.swift
//  evchargers
//
//  Created by John on 10/11/2019.
//  Copyright © 2019 John. All rights reserved.
//
import CoreLocation

typealias LocationViewModel = (name:String, address:String?, coordinate : CLLocationCoordinate2D)


class MapPresenter {
    let pageTitle = "Map Page"
    
    weak var view : MapViewController?
    var router : MapRouterInterface?
    var interactor : MapInteractorInterface?
    var locationViewModels : [LocationViewModel]?
}

extension MapPresenter : MapPresenterInterface{
    func getLocationViewModels() -> [LocationViewModel]?{
        return locationViewModels
    }
    
    func notifyViewLoaded(){
        view?.setupInitialView()
        view?.showLoading()
        interactor?.fetchLocations()
    }
    
    func notifyViewWillAppear(){
        view?.setScreenTitle(with: pageTitle)
    }
    
    func markerSelected(){
    }
    
    // MapInteractor -> MapPresenter
    func locationsFetched(locationList:[Location]){
        var locationViewModels = [LocationViewModel]()
        for location in locationList {
            let locationViewModel : LocationViewModel = (location.name, location.address, location.coordinates)
            locationViewModels.append(locationViewModel)
        }
        self.locationViewModels = locationViewModels
        view?.hideLoading()
        view?.drawChargeLocations()
    }
    
    func locationsFetchFailed(with errorMessage:String){
        router?.presentPopup(with: errorMessage)
    }
    
}
