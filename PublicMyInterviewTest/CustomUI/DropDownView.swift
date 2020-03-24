//
//  DropDownView.swift
//  PublicMyInterviewTest
//
//  Created by ByungHoon Ann on 2020/03/23.
//  Copyright © 2020 ByungHoon Ann. All rights reserved.
//

import Foundation
import UIKit

protocol DropDownViewDelegate {
    func dropDownPressed(string : String)
}

class DropDownView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    var dropDownOptions = ["1","2","3"]
    
    var tableView = UITableView()
    
    var delegate: DropDownViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = .darkGray
        self.backgroundColor = .darkGray
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = .darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row + 1)
        self.delegate?.dropDownPressed(string: dropDownOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}




