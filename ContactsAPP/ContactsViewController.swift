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
    var contactImages = [UIImageView?]()
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
        //let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
        let keys =  [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactImageDataKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        
        do {
            try? contactStore.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                let name = "\(contact.givenName) \(contact.familyName)"
                self.contacts.append(name)
                
                if let image = contact.imageData {
//                    self.contactImages.append(UIImageView(image: UIImage(data: image)))
                    self.contactImages.append(UIImageView(image: UIImage(data: image)))
                }
                
                
            })
        }
        contacts.sort()
        
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
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
//        cell.name.text = filteredContacts[indexPath.row]
        cell.name.text = filteredContacts[indexPath.row]
        cell.phone.text = "+7(800)700-5555"
//        cell.imageContact = contactImages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //todo animate cell
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchResult = searchController.searchBar.text {
            filteredContacts = searchResult.isEmpty ? contacts : contacts.filter({ (str) -> Bool in
                return str.lowercased().contains(searchResult.lowercased())
            })
            self.tableView.reloadData()
        }
    }
    
    
}
