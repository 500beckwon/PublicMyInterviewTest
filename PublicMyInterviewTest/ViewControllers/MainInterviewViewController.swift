//
//  MainInterviewViewController.swift
//  PublicMyInterviewTest
//
//  Created by ByungHoon Ann on 2020/03/07.
//  Copyright © 2020 ByungHoon Ann. All rights reserved.
//

//MARK: - frame과 bounts의 차이,쓰레드,쓰로우
 
import Foundation
import UIKit

public class MainInterviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    public let testTexts = ["Podfile.lock","Git ignore","고차 함수","재귀 함수","객체지향 프로그래밍(OOP)","6","7","8","9","10"]
    
    public var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    public var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    public func setUpMainScrollView() {
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        let scrollEdgeInset = UIEdgeInsets(top: 0, left: 30, bottom: 10, right: 30)
        scrollView.horizontalScrollIndicatorInsets = scrollEdgeInset
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
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
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("pointee" ,targetContentOffset.pointee)
    }
    
    public var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setUpMainScrollView()
        tableViewSizeSetup()
    }
    
    public func mainTitleViewSetup() {
        
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
        navigationController?.pushViewController(vc, animated: true)
    }
}

