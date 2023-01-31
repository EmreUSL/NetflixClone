//
//  UpcomingViewController.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    var viewModel: UpcomingViewModelProtocol = UpcomingViewModel()
    
    private let tableView: UITableView = {
         let tableView = UITableView()
         tableView.register(UpcomingTableViewCell.self,
                           forCellReuseIdentifier: UpcomingTableViewCell.identifier )
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUpcomingMovies()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIU()
        addSubview()
     
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func addSubview() {
        view.addSubview(tableView)
    }
    
    private func setupIU() {
        view.backgroundColor = UIColor.systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier,
                                                       for: indexPath) as? UpcomingTableViewCell
        else {
            return UITableViewCell()
        }
        
        viewModel.configureCell(cell: cell, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}

extension UpcomingViewController: UpcomingViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }    
}
