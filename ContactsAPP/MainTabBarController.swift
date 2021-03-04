//
//  MainTabBarController.swift
//  ContactsAPP
//
//  Created by mac3 on 01.03.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let contactsVC = UINavigationController(rootViewController: ContactsViewController())
    let frequentContactsVC = FrequentContactsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainTabBarVC()
    }
    //MARK: - setupTabBarTitles
    private func configureMainTabBarVC() {
        viewControllers = [contactsVC, frequentContactsVC]
        selectedIndex = 1
        contactsVC.tabBarItem.title = "Search"
        frequentContactsVC.tabBarItem.title = "Most Viewed"
        contactsVC.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        frequentContactsVC.tabBarItem.image = UIImage(systemName: "list.star")
        
    }

}
