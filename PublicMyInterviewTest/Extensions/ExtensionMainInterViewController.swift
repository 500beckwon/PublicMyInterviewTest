//
//  ExtensionMainInterViewController.swift
//  PublicMyInterviewTest
//
//  Created by ByungHoon Ann on 2020/03/24.
//  Copyright © 2020 ByungHoon Ann. All rights reserved.
//
import UIKit

extension MainInterviewViewController: UIScrollViewDelegate {
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("pointee" ,targetContentOffset.pointee)
    }
    
    public func setUpMainScrollView() {
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        let scrollEdgeInset = UIEdgeInsets(top: 0, left: 30, bottom: 10, right: 30)
        scrollView.horizontalScrollIndicatorInsets = scrollEdgeInset
        scrollView.topAnchor.constraint(equalTo: leftTopButton.bottomAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        for i in 0...3 {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 50)
            label.textColor = .black
            label.textAlignment = .center
            label.text = "\(i + 1)"
            let xPosition = view.frame.width * CGFloat(1 * i)
            label.frame = CGRect(x: xPosition, y: 0, width: view.frame.width, height: view.frame.height/2.5)
            scrollView.contentSize.width = view.frame.width * CGFloat(i+1)
            scrollView.addSubview(label)
        }
    }
}


extension MainInterviewViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testTexts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainInterviewTableCell") as? MainInterviewTableCell else { return UITableViewCell() }
        
        cell.textLabel?.text = testTexts[indexPath.row]
        cell.textLabel?.textColor = .black
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailExplainViewController") as? DetailExplainViewController else { return }
        
        switch indexPath.row {
        case 0:
            vc.urlString = "https://jinshine.github.io/2018/05/22/Swift/5.OOP%20in%20Swift/"
        case 1:
            vc.urlString = "https://blog.shako.net/gitignore-generator-for-ios-projects/"
        case 2:
            vc.urlString = "https://zeddios.tistory.com/203"
        case 3:
            vc.urlString = "https://zeddios.tistory.com/231"
        case 4:
            vc.urlString = "https://github.com/ClintJang/cocoapods-tips"
        default:
            print("error! out of range")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    public func tableViewSizeSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        let nibName = UINib(nibName: "MainInterviewTableCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MainInterviewTableCell")
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
