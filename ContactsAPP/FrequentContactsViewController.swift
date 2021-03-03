//
//  FrequentContactsViewController.swift
//  ContactsAPP
//
//  Created by mac3 on 01.03.2021.
//

import UIKit
import Contacts

class FrequentContactsViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var contacts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCollectionView()
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
            })
        }
        contacts.sort()
    }
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}

//MARK: - collectionviewdelegateflowlayout

extension FrequentContactsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
}

//MARK: - collectionview delegate, datasource

extension FrequentContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.systemTeal
        return cell
    }
}
