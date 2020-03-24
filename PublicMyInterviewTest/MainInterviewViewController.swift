//
//  MainInterviewViewController.swift
//  PublicMyInterviewTest
//
//  Created by ByungHoon Ann on 2020/03/07.
//  Copyright © 2020 ByungHoon Ann. All rights reserved.
//

//MARK: - frame과 bounts의 차이,쓰레드,쓰로우
import UIKit
public class MainInterviewViewController: UIViewController, DropDownButtonDelegate {
    
    
    public let testTexts = ["객체지향 프로그래밍(OOP)","Git ignore", "frame, bounds (1)","frame, bounds (2)","Podfile.lock","6","7","8","9","10"]
    
    public var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    public var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var leftTopButton = DropDownButton()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(leftTopButton)
        leftTopButton.delegate = self
        leftTopButton.translatesAutoresizingMaskIntoConstraints = false
        leftTopButton.setTitle("Contents", for: .normal)
        leftTopButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        leftTopButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        leftTopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leftTopButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        setUpMainScrollView()
        tableViewSizeSetup()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    public func dropdownButtonIsSelected(_ isSelected: Bool) {
        if isSelected == true  {
            scrollView.isUserInteractionEnabled = false
        }else{
            scrollView.isUserInteractionEnabled = true
        }
    }
}



