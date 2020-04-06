//
//  MainInterviewViewController.swift
//  PublicMyInterviewTest
//
//  Created by ByungHoon Ann on 2020/03/07.
//  Copyright © 2020 ByungHoon Ann. All rights reserved./*

//

import UIKit
final public class MainInterviewViewController: UIViewController, DropDownButtonDelegate {
    var testText = [
        ExpendControl(isExpend: false, texts: ["객체지향 프로그래밍(OOP)","Git ignore"]),
        ExpendControl(isExpend: false, texts: ["frame, bounds (1)","frame, bounds (2)"]),
        ExpendControl(isExpend: false, texts: ["Podfile.lock","Thread란?","Singleton Patter이란?"]),
        ExpendControl(isExpend: false, texts: ["func에서 사용하는 inout 파라미터란?","Generic이란?"]),
        ExpendControl(isExpend: false, texts: ["REST?/REST API?","프로비저닝/Provisioning"])
    ]
    
     public var testTexts = ["객체지향 프로그래밍(OOP)","Git ignore", "frame, bounds (1)","frame, bounds (2)","Podfile.lock","Thread란?","Singleton Patter이란?","func에서 사용하는 inout 파라미터란?","Generic이란?","REST?/REST API?","프로비저닝/Provisioning"]
    
    public var testTests02 = ["개발자 면접 예상 질문 01","개발자 면접 예상 질문 02","개발자 면접 예상 질문 03"]
    public var filterData = [String]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    public var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .gray
        searchBar.searchTextField.tintColor = .black
        searchBar.searchTextField.backgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    public var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkGray
        button.setTitle("작성", for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
     
        filterData = testTexts
        dropDownButtonSet()
        rightButtonSetUp()
        setUpMainScrollView()
        tableViewSizeSetup()
        searchBarSetUp()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tableView.reloadData()
    }
    
    public func dropdownButtonIsSelected(_ isSelected: Bool) {
        if isSelected == true  {
            scrollView.isUserInteractionEnabled = false
        }else{
            scrollView.isUserInteractionEnabled = true
        }
        
//        if !appDelegate.dropDownText.isEmpty {
//            testTexts = testTests02
//            tableView.reloadData()
//        }
        
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //tableView.reloadData()
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchText = searchBar.searchTextField.text else { return }
//        filterData = searchText.isEmpty ? testTexts : testTexts.filter {  item in
//            return item.range(of: searchText,options: .caseInsensitive,range: nil,locale: nil) != nil
//        }
//        tableView.reloadData()
    }
}



