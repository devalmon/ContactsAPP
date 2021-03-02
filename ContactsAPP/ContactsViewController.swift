//
//  ContactsViewController.swift
//  ContactsAPP
//
//  Created by mac3 on 01.03.2021.
//

import UIKit

class ContactsViewController: UIViewController {
    var searchController = UISearchController()
    var tableView = UITableView()
    var contacts = ["Анна","Маша","Михаил","Григорий","Оксана","Анна","Маша","Михаил","Григорий","Оксана","Анна","Маша","Михаил","Григорий","Оксана","Анна","Маша","Михаил","Григорий","Оксана","Маша","Михаил","Григорий","Оксана","Анна","Маша","Михаил","Григорий","Оксана","Анна","Маша","Михаил","Григорий","Оксана","Max","Den","Anna","John"]
    var filteredContacts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureSearchController()
        configureTableView()
    }
    
    //MARK: - config
    private func configureVC() {
        view.backgroundColor = UIColor.white
        filteredContacts = contacts
    }
    
    private func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.white
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = filteredContacts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}

extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchResult = searchController.searchBar.text {
            filteredContacts = searchResult.isEmpty ? contacts : contacts.filter({ (str) -> Bool in
                return str.rangeOfCharacter(from: CharacterSet(charactersIn: searchResult), options: .caseInsensitive, range: nil) != nil
            })
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
}
