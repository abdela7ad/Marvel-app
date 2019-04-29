//
//  MovieListViewController.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit
import GenericDataSources
import CRRefresh
class MovieListViewController: UIViewController {

    @IBOutlet private weak var tableView : UITableView!
    
    var dataSource  = CharacterListDatasource()
    
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
        tableView.ds_register(cellNib: LoadingViewCell.self)

       dataSource.selectedDataSourceIndex = 0
       tableView.ds_useDataSource(dataSource)
        
        dataSource.onDidSelect.subscribe(with: self) { (item) in
            DispatchQueue.main.async {
                  self.viewModel.showCharacter(characterViewModel: item)
              }
        }
        
//         let selectionHandler =  BlockSelectionHandler<CharacterViewModelType,MarvelCharacterViewCell>()
//        dataSource?.setSelectionHandler(selectionHandler)
//
//        selectionHandler.didSelectBlock = { (datasource, tableView, indexPath)  in
//
//            DispatchQueue.main.async {
//               self.viewModel.showCharacter(characterViewModel: datasource.items[indexPath.row])
//            }
//        }
        
        tableView.cr.addFootRefresh(animator: NormalFooterAnimator()) {
            self.viewModel.next()
        }
        
    }
    
    private func bindViewModel(){
        
       
        viewModel.mentorViewState.subscribe(with: self) { (state) in
            
            switch state {
            case let .loaded(items: items):
                self.dataSource.setCharactersItems(items: items)
                self.dataSource.selectedDataSourceIndex = 1
                self.tableView.reloadData()
                self.tableView.cr.endLoadingMore()
            default:
                break
            }
        }
    }

}
