//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import UIKit


enum Section: Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProcol = HomeViewModel()
    var cellProtocol = HomeTableViewCell()

    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(HomeTableViewCell.self,
                           forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.reloadData()
       }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureNavBar()
        addSubViews()
        setupColor()
        addHeaderView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
    }
    
    private func setupColor() {
        view.backgroundColor = UIColor.systemBackground
    }
    
    private func addHeaderView() {
        let headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        tableView.tableHeaderView = headerView
    }
    
    private func configureNavBar() {
            navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
   
    
}


//MARK: - TableViewDelegate, TableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier,
                                                       for: indexPath) as? HomeTableViewCell
        else {
            return UITableViewCell()
        }
       
        cell.delegate = self
        switch indexPath.section {
        case Section.TrendingMovies.rawValue:
            viewModel.getTrendingMovies(cell: cell)
        case Section.TrendingTv.rawValue:
            viewModel.getTrendingTv(cell: cell)
        case Section.Popular.rawValue:
            viewModel.getPopularMovies(cell: cell)
        case Section.Upcoming.rawValue:
            viewModel.getUpcomingMovies(cell: cell)
        case Section.TopRated.rawValue:
            viewModel.getTopRated(cell: cell)
        default:
            break
        }
        
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getSectionTitle(section: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18,weight: .semibold)
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y + 20,
                                         width: 100,
                                         height: header.bounds.height)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: HomeTableViewCell, model: PreviewModel) {
        DispatchQueue.main.async {
          //  let vc = TitlePreviewViewController()
        //    vc.configure(with: model)
          //  self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
}
