//
//  HomeScene.swift
//  NetflixClone
//
//  Created by emre usul on 30.01.2023.
//

import UIKit

protocol HomeSceneInterface: AnyObject {
    func configureVC()
    func configureTableView()
}

final class HomeScene: UIViewController {
    
    private let viewModel = HomeSceneViewModel()
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
}

extension HomeScene: HomeSceneInterface {
    func configureVC() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"),
                            style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"),
                            style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = UIColor.red
    }
    
    
    func configureTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(HomeTableViewCell.self,
                           forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        let headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0,
                                                      width: view.bounds.width,
                                                      height: 450))
        tableView.tableHeaderView = headerView
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
    }
}

extension HomeScene: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier,
                                                       for: indexPath) as? HomeTableViewCell
        else { return UITableViewCell()}
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    
}
    
