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
public class MainInterviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, DropDownViewDelegate {
    func dropDownPressed(string: String) {
        rightButton.title = string
        dismissDropDown()
    }
    
    
    var button = DropDownButton()
    var dropView = DropDownView()
    public let testTexts = ["객체지향 프로그래밍(OOP)","Git ignore","고차 함수","재귀 함수","Podfile.lock","6","7","8","9","10"]
    
    public var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        var height = NSLayoutConstraint()
        button.tag = 0
        return button
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonPressed(_:)))
        button.tag = 1
        return button
    }()
    
    public var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("button", for: .normal)
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dropView.delegate = self
       
        setUpMainScrollView()
        tableViewSizeSetup()
        buttonSetUp()
    }
    
    func buttonSetUp() {
        
        navigationItem.rightBarButtonItem = rightButton
    }
    var isOpen = false
    var height = NSLayoutConstraint()
    
    //FIXME: 테스트 용 DropDownView을 응용해서 BarButtonItem에 억지로 넣은 코드 추후 개조 필요
    @objc func buttonPressed(_ sender: Any) {
        
        if let barbutton = sender as? UIBarButtonItem {
            switch barbutton.tag {
            case 1:
                view.addSubview(dropView)
                if isOpen == true {
                    isOpen = false
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                        self.dropView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                    })
                }else {
                    isOpen = true
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.dropView.frame = CGRect(x: 200, y: 40, width: 200, height: 200)
                })
                }
            case 2:
                print("1111")
            default:
                print("33")
            }
        }
    }
    
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
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
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
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
    
    public func tableViewSizeSetup() {
        
        tableView.dataSource = self
        tableView.delegate = self
        let nibName = UINib(nibName: "MainInterviewTableCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MainInterviewTableCell")
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: button.dropView.bottomAnchor).isActive = true
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
        if indexPath.row == 0 {
            vc.urlString = "https://jinshine.github.io/2018/05/22/Swift/5.OOP%20in%20Swift/"
        }
        if indexPath.row == 1 {
            vc.urlString = "https://blog.shako.net/gitignore-generator-for-ios-projects/"
        }
        if indexPath.row == 4 {
        vc.urlString = "https://github.com/ClintJang/cocoapods-tips"
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}


