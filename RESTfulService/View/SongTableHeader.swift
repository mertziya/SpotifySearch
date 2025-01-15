//
//  SearchBarvİEW.swift
//  RESTfulService
//
//  Created by Mert Ziya on 8.01.2025.
//

import Foundation
import UIKit


class SongTableHeader : UITableViewHeaderFooterView{
    
    var searchBar = UITextField()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        self.backgroundColor = .systemBackground
        self.addSubview(searchBar)
        
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [
            .foregroundColor : UIColor.label
        ])
        searchBar.layer.cornerRadius = 12
        searchBar.backgroundColor = .secondarySystemBackground
        
        
        // search Icon Logic:
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.tintColor = .label
        
        searchIcon.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        let containerView = UIView(frame: CGRect(x: 10, y: 0, width: 34, height: 20))
        
        containerView.addSubview(searchIcon)
        
        searchBar.leftView = containerView
        searchBar.leftViewMode = .always
        
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
}
