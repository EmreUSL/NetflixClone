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

extension DownloadScene: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.movieTitle.count)
        return viewModel.movieTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier,
                                                       for: indexPath) as? UpcomingTableViewCell
        else { return UITableViewCell() }
       
        let model = viewModel.movieTitle[indexPath.row]
        cell.configureCell(with: MovieModel(titleName: model.title ?? model.original_name ?? "", posterURL: model.poster_path ?? ""))
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
    
}
