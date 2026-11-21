//
//  TabBarController.swift
//  MapasCamara
//
//  Created by Daniel Esteban Alcantara on 21/11/26.
//

import UIKit

class TabBarViewController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
    }
    
    private func setUpViewControllers(){
        //MARK: Mapas
        let mapsViewController = MapsViewController()
        let mapsNavigation = UINavigationController(rootViewController: mapsViewController)
        mapsNavigation.tabBarItem.title = "Mapas"
        mapsNavigation.tabBarItem.image = UIImage(systemName: "mappin.circle")
        
        //MARK: Camara
        let camaraViewController = CamaraViewController()
        let camaraNavigation = UINavigationController(rootViewController: camaraViewController)
        camaraNavigation.tabBarItem.title = "Camara"
        camaraNavigation.tabBarItem.image = UIImage(systemName: "camera.fill")
        
        //MARK: ViewControllersArray
        let viewControllers : [UIViewController] = [mapsNavigation, camaraNavigation]
        self.viewControllers = viewControllers
        self.selectedIndex = 0
    }
    
    
}
