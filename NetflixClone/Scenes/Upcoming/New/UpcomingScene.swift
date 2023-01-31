//
//  UpcomingScene.swift
//  NetflixClone
//
//  Created by emre usul on 31.01.2023.
//

import UIKit

protocol UpcomingSceneInterface: AnyObject {
    func configureUI()
    func configureTableView()
    func reloadUI()
}

final class UpcomingScene: UIViewController {
    
    private let viewModel = UpcomingSceneViewModel()
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    

}

extension UpcomingScene: UpcomingSceneInterface {
 
    func configureUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UpcomingTableViewCell.self,
                           forCellReuseIdentifier: UpcomingTableViewCell.identifier)

        view.addSubview(tableView)
      

    }
    
    func reloadUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension UpcomingScene: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier,
                                                       for: indexPath) as? UpcomingTableViewCell
        else { return UITableViewCell() }
        
        let movie = viewModel.upcomingMovies[indexPath.row]
        let movieModel = MovieModel(titleName: movie.title ?? "",
                                    posterURL: movie.poster_path ?? "")
        cell.configureCell(with: movieModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}


