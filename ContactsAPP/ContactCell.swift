//
//  ContactCell.swift
//  ContactsAPP
//
//  Created by Alexey Baryshnikov on 03.03.2021.
//

import UIKit

class ContactCell: UITableViewCell {
    static let identifier = "ContactCell"
    
    var imageContact: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.systemTeal
        image.clipsToBounds = true
        return image
    }()
    var name: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 25)
        return name
    }()
    var phone: UILabel = {
        let phone = UILabel()
        return phone
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(imageContact)
        contentView.addSubview(name)
        contentView.addSubview(phone)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageContact()
        layoutTextInfo()
    }
    
    //MARK: - config
    private func layoutImageContact() {
        imageContact.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageContact.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageContact.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageContact.widthAnchor.constraint(equalToConstant: 70),
            imageContact.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        imageContact.layer.cornerRadius = imageContact.frame.height / 2
    }
    private func layoutTextInfo() {
        name.translatesAutoresizingMaskIntoConstraints = false
        phone.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: imageContact.trailingAnchor, constant: 10),
            name.topAnchor.constraint(equalTo: imageContact.topAnchor, constant: 5),
            name.heightAnchor.constraint(equalToConstant: 26),
            phone.leadingAnchor.constraint(equalTo: imageContact.trailingAnchor, constant: 10),
            phone.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            phone.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
