//
//  AppCoordinator.swift
//  Ryaheen-ios
//
//  Created by Abdelahad on 3/10/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit





enum DeepLink {
}


 class AppCoordinator : WindowCoordinator<DeepLink> {
 
    private var window: UIWindow
    
   private lazy var navController: UINavigationController = {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        return navController
    }()
    
     init(window: UIWindow) {
        self.window = window
        super.init(router: WindowRouter(window: window))
        window.makeKeyAndVisible()
    }
    
    override func start(with link: DeepLink?) {
        runMainFlow(with: link)
    }
    
   private func showSplashScreen(with link: DeepLink?) {
          let splashScreenController = SplashScreenViewController()
          navController.viewControllers = [splashScreenController]
          router.setRootModule(navController)
    }
    
    private func runMainFlow(with link: DeepLink?) {
        router.setRootModule(navController)
        let mainFlowCoordinator = MainFlowCoordinator(router: Router(navigationController: navController))
        addChild(mainFlowCoordinator)
        mainFlowCoordinator.start(with: link)
    }
    

}
