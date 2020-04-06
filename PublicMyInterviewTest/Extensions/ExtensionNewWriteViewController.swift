//
//  ExtensionNewWriteViewController.swift
//  PublicMyInterviewTest
//
//  Created by ByungHoon Ann on 2020/03/28.
//  Copyright © 2020 ByungHoon Ann. All rights reserved.
//

import UIKit

extension NewWriteViewController{
    
    public func topLabelSetUp() {
        view.addSubview(topLabel)
        let safeGuide = view.safeAreaLayoutGuide
        topLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        topLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    public func websetUp() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        view.addSubview(customWebKitView)
        customWebKitView.delegate = self
        customWebKitView.translatesAutoresizingMaskIntoConstraints = false
        customWebKitView.topAnchor.constraint(equalTo: topLabel.bottomAnchor).isActive = true
        customWebKitView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor).isActive = true
        customWebKitView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor,constant: 1).isActive = true
        customWebKitView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor,constant: -1).isActive = true
    }
    
    public func writeViewSetUp() {
        view.addSubview(writeView)
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        writeView.translatesAutoresizingMaskIntoConstraints = false
        writeView.alpha = 0.0
        writeView.isHidden = true
        writeView.topAnchor.constraint(equalTo: self.topLabel.bottomAnchor).isActive = true
        writeView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor).isActive = true
        writeView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor,constant: 1).isActive = true
        writeView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor,constant: -1).isActive = true
    }
    
    public func tableViewSetUp() {
        view.addSubview(tableView)
        let nibName = UINib(nibName: "NewWriteTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "NewWriteTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.topAnchor.constraint(equalTo: topLabel.bottomAnchor,constant: 1).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -1).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: CGFloat(sampleTexts.count * 50)).isActive = true
    }
}

extension NewWriteViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionSample.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewWriteCollectionViewCell", for: indexPath) as? NewWriteCollectionViewCell else { return UICollectionViewCell()}
        cell.backgroundColor = collectionSample[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width/3 - 8
        let cellSize = CGSize(width: width, height: width)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.5, left: 1, bottom: 0.5, right: 1)
    }
}
