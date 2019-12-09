//
//  MapRouter.swift
//  evchargers
//
//  Created by John on 10/11/2019.
//  Copyright © 2019 John. All rights reserved.
//

import UIKit

class MapRouter: NSObject {
    
    weak var presenter : MapPresenter?
    weak var navigationController:UINavigationController?
    
    static func createModule() -> UINavigationController{
        
        // Create layers
        let router = MapRouter()
        let presenter = MapPresenter()
        let interactor = MapInteractor()
        let view = MapViewController(nibName: "MapView", bundle: nil)
        let nav = UINavigationController.init(rootViewController: view)
        
        // Connect layers
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        router.navigationController = nav
        
        return nav
    }
}

extension MapRouter : MapRouterInterface{
    
    func performSegue(with identifier: String) {
        self.navigationController?.visibleViewController?.performSegue(withIdentifier: identifier, sender: nil)
    }
    
    func presentPopup(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Allright", style: .default, handler: nil))
        self.navigationController?.visibleViewController?.present(alertController, animated: true, completion: nil)
    }
}
