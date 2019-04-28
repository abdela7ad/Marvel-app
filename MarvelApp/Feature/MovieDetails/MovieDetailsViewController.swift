//
//  MovieDetailsViewController.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    
    private let datasource = CharacterDetailDatasource()
    
    
    var viewModel : CharacterDetailViewModel
    
    init(viewModel:CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: MovieDetailsViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatasource()
    }
    
    func setupDatasource(){
        tableView.ds_useDataSource(datasource)
        datasource.characterDetails = viewModel
        tableView.ds_register(cellNib: CategoryViewCell.self)
        tableView.ds_register(cellNib: RelatedLinkLabelViewCell.self)
        tableView.ds_register(cellNib: CharacterInfoViewCell.self)
        tableView.ds_register(cellNib: RelatedLinkViewCell.self)

    }
}
