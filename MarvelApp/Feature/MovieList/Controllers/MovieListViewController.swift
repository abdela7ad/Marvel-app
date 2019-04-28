//
//  MovieListViewController.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit
import GenericDataSources

class MovieListViewController: UIViewController {

    @IBOutlet private weak var tableView : UITableView!
    
    var dataSource : BasicBlockDataSource<CharacterViewModelType,MarvelCharacterViewCell>?
    
    let viewModel : CharachterListViewModel
    
    init(viewModel : CharachterListViewModel = CharachterListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: MovieListViewController.self), bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.getMovieList()

       setUpDataSource()
       bindViewModel()
        
    }

    private func setUpDataSource(){
        
        tableView.ds_register(cellNib: MarvelCharacterViewCell.self)
        
       dataSource = BasicBlockDataSource<CharacterViewModelType,MarvelCharacterViewCell>(configureBlock: { (characterViewModelType, cell, indexPath) in
            cell.configure(cellViewModel: characterViewModelType)
        })
       tableView.ds_useDataSource(dataSource!)
        
         let selectionHandler =  BlockSelectionHandler<CharacterViewModelType,MarvelCharacterViewCell>()
        dataSource?.setSelectionHandler(selectionHandler)
        
        selectionHandler.didSelectBlock = { (datasource, tableView, indexPath)  in
            
            DispatchQueue.main.async {
               self.viewModel.showCharacter(characterViewModel: datasource.items[indexPath.row])
            }
        }
    }
    
    private func bindViewModel(){
        
       
        viewModel.mentorViewState.subscribe(with: self) { (state) in
            
            switch state {
            case let .loaded(items: items):
                self.dataSource?.items = items
                self.tableView.reloadData()
            default:
                break
            }
        }
    }

}
