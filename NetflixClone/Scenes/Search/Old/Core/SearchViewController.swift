//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import UIKit


class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModelProtocol = SearchViewModel()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UpcomingTableViewCell.self,
                           forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for Movie or a Tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getDiscoverMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupUI() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = UIColor.systemBackground
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
    
    }
}

extension SearchViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier,
                                                       for: indexPath) as? UpcomingTableViewCell
        else { return UITableViewCell() }
        viewModel.configureCell(cell: cell, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}

extension SearchViewController: SearchViewModelDelegate {
    func reloadUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
            //  query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController
        else { return }
        
        SearchResultViewController.query = query
        resultController.viewWillAppear(true)
        
       
    }
}
