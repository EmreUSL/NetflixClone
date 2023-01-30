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
    func reloadUI()
}


//MARK: - HomeScene

final class HomeScene: UIViewController {
    
    private let viewModel = HomeSceneViewModel()
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    private func willDisplayHeader(view: UIView) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18,weight: .semibold)
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y + 20,
                                         width: 100,
                                         height: header.bounds.height)
    }
    
    private func scrollViewScroll(scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
}

//MARK: - HomeSceneInterface

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
    
    func reloadUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableViewDelegate , TableViewDataSource

extension HomeScene: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier,
                                                       for: indexPath) as? HomeTableViewCell
        else { return UITableViewCell()}
        
        cell.configureCell(titles: viewModel.getSectionsData(section: indexPath.section))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.getSectionTitle(index: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        willDisplayHeader(view: view)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewScroll(scrollView: scrollView)
    }
}
    
