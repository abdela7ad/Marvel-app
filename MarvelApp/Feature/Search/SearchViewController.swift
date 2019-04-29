//
//  SearchViewController.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/29/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit
import GenericDataSources

class SearchViewController: UIViewController {

    var datasource : BasicBlockDataSource<CharacterViewModelType,SearchReultViewCell>?
    var viewModel = SearchViewModel()
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!

    

    init() {
        super.init(nibName: String(describing: SearchViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()
    }
    
    
    func setupDataSource(){
        
        
        datasource = BasicBlockDataSource<CharacterViewModelType,SearchReultViewCell>.init(configureBlock: { (characterViewModelType, cell, indexPath) in
            cell.configure(cellViewModel: characterViewModelType)
        })
        tableView.ds_useDataSource(datasource!)
        tableView.ds_register(cellNib: SearchReultViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        
        viewModel.items.subscribe(with: self) { (items) in
            self.datasource?.items = items
            self.tableView.reloadData()
        }
        
        let selector = BlockSelectionHandler<CharacterViewModelType,SearchReultViewCell>()
        selector.didSelectBlock = {(datasource,tableView,indexPath) in
            self.viewModel.onDidSelect.fire(datasource.items[indexPath.row])
        }
        
        datasource?.setSelectionHandler(selector)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async{
            self.searchBar.becomeFirstResponder()
        }
    }
    
    

}

extension SearchViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewModel.searchCharacter(query: searchText)
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      //  self.searchViewModel.performSearch()

    }
    
    @IBAction func cancel (_ sender: UIButton) {
        self.viewModel.onDismiss.fire(Void())
    }
    
}

