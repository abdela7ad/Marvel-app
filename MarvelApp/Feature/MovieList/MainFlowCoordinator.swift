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
            self.showCharacterDeials(characterViewModel: characterViewModel)
        }
    }
    
    private func showCharacterDeials(characterViewModel:CharacterViewModelType){
        let viewModel = CharacterDetailViewModel(characterViewModel: characterViewModel)
        let characterDetailsViewController = MovieDetailsViewController(viewModel: viewModel)

        router.push(characterDetailsViewController, animated: true, completion: nil)
    }

}
