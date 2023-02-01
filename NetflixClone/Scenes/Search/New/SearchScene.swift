//
//  SearchScene.swift
//  NetflixClone
//
//  Created by emre usul on 1.02.2023.
//

import UIKit

protocol SearchSceneInterface: AnyObject {
     func configureUI()
     func configureTableView()
     func configureSearchController()
     func reloadUI()
}

final class SearchScene: UIViewController {
    
    private let viewModel = SearchSceneViewModel()
    
    private var tableView: UITableView!
    private var searchController: UISearchController!
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidload()
    }
}

extension SearchScene: SearchSceneInterface {

    func configureUI() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = UIColor.systemBackground
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
    }
    
    func configureTableView() {
        tableView = UITableView(frame: .zero)
        tableView.register(UpcomingTableViewCell.self,
                           forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        view.addSubview(tableView)
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: SearchResultViewController())
        searchController.searchBar.placeholder = "Search for Movie or a TV show"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchResultsUpdater = self
    }
    
    func reloadUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension SearchScene: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.discoverMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier,
                                                       for: indexPath) as? UpcomingTableViewCell
        else { return UITableViewCell() }
        
        let data = viewModel.getCellData(index: indexPath.row)
        cell.configureCell(with: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
}

extension SearchScene: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
