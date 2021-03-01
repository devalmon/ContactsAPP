//
//  ContactsViewController.swift
//  ContactsAPP
//
//  Created by mac3 on 01.03.2021.
//

import UIKit

class ContactsViewController: UIViewController {

    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTextField()
    }
    
    //MARK: - config
    private func configureVC() {
        view.backgroundColor = UIColor.white
    }
    
    private func configureTextField() {
        //Layout
        searchBar.placeholder = "search"
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
