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
    func navigateToDetailScreen(movie: PreviewModel)
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
        tableView = UITableView(frame: .zero)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TableViewCell.self,
                           forCellReuseIdentifier: TableViewCell.identifier)

        view.addSubview(tableView)
    }
    
    func reloadUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func navigateToDetailScreen(movie: PreviewModel) {
        DispatchQueue.main.async {
            let detailScreen = MoviePreviewScene(model: movie)
            self.navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
}

extension UpcomingScene: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier,
                                                       for: indexPath) as? TableViewCell
        else { return UITableViewCell() }
        
        let movie = viewModel.upcomingMovies[indexPath.row]
        let movieModel = MovieModel(titleName: movie.title ?? "",
                                    posterURL: movie.poster_path ?? "")
        cell.configureCell(with: movieModel)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = viewModel.upcomingMovies[indexPath.row]
        viewModel.getDetailTitle(title: title.title ?? title.original_name ?? "", overview: title.overview ?? "")
    }
}


