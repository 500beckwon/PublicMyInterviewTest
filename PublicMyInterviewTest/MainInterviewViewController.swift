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
     var dropView = DropdownView()
    public let testTexts = ["Podfile.lock","Git ignore","고차 함수","재귀 함수","객체지향 프로그래밍(OOP)","6","7","8","9","10"]
    
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
    var height = NSLayoutConstraint()
    func leftbabutt() {
        dropView = DropdownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        leftButton.bringSubviewToFront(dropView)
        leftButton.superview?.addSubview(dropView)
        
        dropView.topAnchor.constraint(equalTo: leftButton.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: leftButton.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: leftButton.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
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
        buttonSetUp()
   
    }
    
    var isOpen = false
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 150
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5,initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
            },completion: nil)
        } else {
            isOpen = false
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5,initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
            },completion: nil)
        }
    }
    
    public func mainTitleViewSetup() {
        
    }
    
    func buttonSetUp() {
        navigationItem.rightBarButtonItem = rightButton
       
    }
    @objc func buttonPressed(_ sender: Any) {
        
        if let barbutton = sender as? UIBarButtonItem {
            switch barbutton.tag {
            case 1:
                print("2")
            case 2:
                print("1111")
            default:
                print("33")
            }
        }
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


class DropdownView: UIView,UITableViewDelegate, UITableViewDataSource {
   
    var tableView = UITableView()
    var dropDownOption = [String]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .darkGray
        self.backgroundColor = .cyan
        self.addSubview(tableView)
        
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dropDownOption[indexPath.row]
        cell.backgroundColor = .darkGray
        return cell
    }
    
    
}
