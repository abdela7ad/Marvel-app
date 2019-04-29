//
//  SearchCoordinator.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/29/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import Signals
final class SearchCoordinator : Coordinator<DeepLink> {
    
    
    var  onFinishFlow = Signal<Void>()
    
    override init(router: RouterType = Router()) {
        super.init(router: router)
    }
    
    override func start(with link: DeepLink?) {
        showSearch()
    }
    
    private func showSearch(){
        let searchController = SearchViewController();   router.navigationController.isNavigationBarHidden = true
        router.setRootModule(searchController, hideBar: true)
        searchController.viewModel.onDidSelect.subscribe(with: self) { (viewModel) in
            self.runCharacterDeials(characterViewModel: viewModel)
        }
        searchController.viewModel.onDismiss.subscribe(with: self) { (_) in
            self.onFinishFlow.fire(Void())
        }
    }
    
    private func runCharacterDeials(characterViewModel:CharacterViewModelType ){
        
        
        let characterDetailsCoordinator =  CharacterInfoCoordinator(router: router, characterViewModel: characterViewModel)
        addChild(characterDetailsCoordinator)
        characterDetailsCoordinator.start()
        characterDetailsCoordinator.onFinishFlow.subscribe(with: self) { (router) in
            router.popModule(animated: false)
            self.removeChild(characterDetailsCoordinator)
        }
    }
}
