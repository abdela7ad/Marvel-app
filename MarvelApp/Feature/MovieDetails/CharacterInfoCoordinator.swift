//
//  CharacterInfoCoordinator.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/29/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation
import Signals
final class CharacterInfoCoordinator : Coordinator<DeepLink> {
    
    private var  characterViewModel:CharacterViewModelType
    
     var  onFinishFlow = Signal<Void>()

    init(router: RouterType = Router() , characterViewModel : CharacterViewModelType) {
        self.characterViewModel = characterViewModel
        super.init(router: router)
    }
    
    override func start(with link: DeepLink?) {
        showCharacterDeials(characterViewModel: characterViewModel)
    }
    
    private func showCharacterDeials(characterViewModel:CharacterViewModelType){
        let viewModel = CharacterDetailViewModel(characterViewModel: characterViewModel)
        let characterDetailsViewController = MovieDetailsViewController(viewModel: viewModel)
        router.navigationController.isNavigationBarHidden = true
        router.push(characterDetailsViewController, animated: true, completion: nil)
        viewModel.onDidSelectBack.subscribe(with: self) { (_) in
            self.onFinishFlow.fire(Void())
        }
    }
    
}
