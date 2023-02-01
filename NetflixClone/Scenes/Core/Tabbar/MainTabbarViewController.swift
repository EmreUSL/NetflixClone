//
//  ViewController.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import UIKit

final class MainTabbarViewController: UITabBarController {
    
    let HomeVC = UINavigationController(rootViewController: HomeScene())
    let UpcomingVC = UINavigationController(rootViewController: UpcomingScene())
    let SearchVC = UINavigationController(rootViewController: SearchScene())
    let DownloadsVC = UINavigationController(rootViewController: DownloadsViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupColor()
        setImageTabBarItem()
        setViewControllers()
        setTabBarItemsTitle()
    }
    
    private func setupColor() {
        view.backgroundColor = UIColor.yellow
        tabBar.tintColor = UIColor.label
    }
    
    private func setImageTabBarItem() {
        HomeVC.tabBarItem.image = UIImage(systemName: "house")
        UpcomingVC.tabBarItem.image = UIImage(systemName: "play.circle")
        SearchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        DownloadsVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
    }
    
    private func setViewControllers() {
        setViewControllers([HomeVC,UpcomingVC,SearchVC,DownloadsVC], animated: true)
    }
    
    private func setTabBarItemsTitle() {
        HomeVC.title = "Home"
        UpcomingVC.title = "Coming Soon"
        SearchVC.title = "Top Search"
        DownloadsVC.title = "Downloads"
    }
    
}
