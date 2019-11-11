//
//  MapInteractor.swift
//  evchargers
//
//  Created by John on 10/11/2019.
//  Copyright © 2019 John. All rights reserved.
// 
import AFNetworking

class MapInteractor {
    weak var presenter : MapPresenter?
}

extension MapInteractor : MapInteractorInterface {
    func fetchLocations(){
        if let bundleDict = Bundle.main.infoDictionary,
            let url = bundleDict["API_URL" as String] as? String {
            let baseURL = URL.init(string: url)!
            let manager = AFHTTPSessionManager.init(baseURL: baseURL)
            manager.get("charger",
                        parameters: nil,
                        progress: nil,
                        success: {(operation, responseObject) in
                            if let responseArray = responseObject as? [[String : Any]] {
                                let locations = responseArray.compactMap { item in
                                    return Location(dict: item)
                                }
                                self.presenter?.locationsFetched(locationList: locations)
                            }
            }, failure: {(operation, error) in
                self.presenter?.locationsFetchFailed(with: error.localizedDescription)
            })
        }
    }
    
}
