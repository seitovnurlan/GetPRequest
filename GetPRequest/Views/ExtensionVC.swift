//
//  ExtensionVC.swift
//  GetPRequest
//
//  Created by Nurlan Seitov on 6/4/23.
//

import UIKit

extension UIViewController {
    
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemRed
    }
    
    func createCustomTitleView(contactName: String, contactDescription: String, contactImage: String) -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 280, height: 41)
        
        let imageContact = UIImageView()
        imageContact.image = UIImage(named: contactImage)
        imageContact.layer.cornerRadius = imageContact.frame.height / 2
        imageContact.frame = CGRect(x: 5, y: 0, width: 40, height: 40)
        view.addSubview(imageContact)
        
        let nameLabel = UILabel()
        nameLabel.text = contactName
        nameLabel.frame = CGRect(x: 55, y: 0, width: 220, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(nameLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = contactDescription
        descriptionLabel.frame = CGRect(x: 55, y: 21, width: 220, height: 20)
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .systemGray
        view.addSubview(descriptionLabel)
        
        return view
    }
    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
       
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        button.tintColor = .systemBlue
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.systemBlue.cgColor
//        button.layer.cornerRadius = 5
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}

