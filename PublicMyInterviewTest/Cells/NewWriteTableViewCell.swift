//
//  NewWriteViewController.swift
//  PublicMyInterviewTest
//
//  Created by ByungHoon Ann on 2020/03/28.
//  Copyright © 2020 ByungHoon Ann. All rights reserved.
//

import UIKit

final class NewWriteTableViewCell: UITableViewCell {
    var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(label)
        self.backgroundColor = .white
        label.topAnchor.constraint(equalTo: self.topAnchor,constant: 5).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:15).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant:  -5).isActive = true
    }
}
