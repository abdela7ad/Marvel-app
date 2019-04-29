//
//  MainFlowCoordinator.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit


final class MainFlowCoordinator : Coordinator<DeepLink> {
    
    override init(router: RouterType = Router()) {
        super.init(router: router)
    }
    
    override func start(with link: DeepLink?) {
        showMovieList(with: link)
    }
    
    private func showMovieList(with link: DeepLink?){
        let movieListViewController = MovieListViewController()
        router.setRootModule(movieListViewController, hideBar: false)
        movieListViewController.viewModel.didSelectCharacter.subscribe(with: self) { (characterViewModel) in
            self.runCharacterDeials(characterViewModel: characterViewModel)
        }
        
        movieListViewController.viewModel.searchHandler.subscribe(with: self) { (characterViewModel) in
            self.runSearchView()
        }
        
    }
    
    private func runCharacterDeials(characterViewModel:CharacterViewModelType ){
        
        
        let characterDetailsCoordinator =  CharacterInfoCoordinator(router: router, characterViewModel: characterViewModel)
        addChild(characterDetailsCoordinator)
        characterDetailsCoordinator.start()
        characterDetailsCoordinator.onFinishFlow.subscribe(with: self) { (router) in
            router.popModule(animated: false)
            router.navigationController.isNavigationBarHidden = false
            self.removeChild(characterDetailsCoordinator)
        }
    }
    
    private func runSearchView(){
        
        let searchCoordinator =  SearchCoordinator()
        addChild(searchCoordinator)
        searchCoordinator.start()
        searchCoordinator.onFinishFlow.subscribe(with: self) { (_) in
            self.router.dismissModule(animated: true, completion: nil)
            self.removeChild(searchCoordinator)
        }
        router.present(searchCoordinator.toPresentable(), animated: true)
    }

}
