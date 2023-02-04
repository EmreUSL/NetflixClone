//
//  DowloadsViewController.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import UIKit

protocol DownloadSceneInterface: AnyObject {
    func configureUI()
    func configureTableView()
    func reloadUI()
    func navigateToDetailScreen(movie: PreviewModel)
}

final class DownloadScene: UIViewController {
    
    private let viewModel = DownloadSceneViewModel()
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension DownloadScene: DownloadSceneInterface {
  
    func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureTableView() {
        tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
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

extension DownloadScene: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier,
                                                       for: indexPath) as? TableViewCell
        else { return UITableViewCell() }
       
        let model = viewModel.movieTitle[indexPath.row]
        cell.configureCell(with: MovieModel(titleName: model.title ?? model.original_name ?? "", posterURL: model.poster_path ?? ""))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            viewModel.deleteData(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = viewModel.movieTitle[indexPath.row]
        viewModel.getDetailTitle(title: title.title ?? title.original_name ?? "", overview: title.overview ?? "")
    }
}

