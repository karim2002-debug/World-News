//
//  MainTabBarViewController.swift
//  World News
//
//  Created by Macbook on 06/07/2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: SavedViewController())

        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Saved"

        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "bookmark")

         tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
        tabBar.barTintColor = .black
        tabBar.backgroundColor = .white
        setViewControllers([vc1,vc2,vc3], animated: true)
        
    }
}
