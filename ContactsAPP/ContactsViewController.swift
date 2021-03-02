//
//  ContactsViewController.swift
//  ContactsAPP
//
//  Created by mac3 on 01.03.2021.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController {
    var searchController = UISearchController()
    var tableView = UITableView()
    var contacts = [String]()
    var filteredContacts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureSearchController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - config
    private func configureVC() {
        view.backgroundColor = UIColor.white
        
        let contactStore = CNContactStore()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try? contactStore.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                let name = "\(contact.givenName) \(contact.familyName)"
                self.contacts.append(name)
            })
        }
        
        filteredContacts = contacts
//        title = "Search"
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "search a person"
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //todo animate cell
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
            cell.alpha = 1
        }
    }
    
    
}

extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchResult = searchController.searchBar.text {
            filteredContacts = searchResult.isEmpty ? contacts : contacts.filter({ (str) -> Bool in
                return str.rangeOfCharacter(from: CharacterSet(charactersIn: searchResult), options: .caseInsensitive, range: nil) != nil
            })
            self.tableView.reloadData()
        }
    }
    
    
}
