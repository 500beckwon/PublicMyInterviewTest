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
        scrollView.backgroundColor = .clear
        for i in 0...3 {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 50)
            label.textColor = .black
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.text = "\(i + 1)"
            let xPosition = view.frame.width * CGFloat(1 * i)
            label.frame = CGRect(x: xPosition, y: 0, width: view.frame.width, height: view.frame.height/2.5)
            scrollView.contentSize.width = view.frame.width * CGFloat(i+1)
            scrollView.addSubview(label)
        }
    }
    
    public func dropDownButtonSet() {
        view.addSubview(leftTopButton)
        leftTopButton.delegate = self
        leftTopButton.translatesAutoresizingMaskIntoConstraints = false
        leftTopButton.setTitle("Contents", for: .normal)
        leftTopButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        leftTopButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        leftTopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leftTopButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    public func rightButtonSetUp() {
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.addTarget(self, action: #selector(rightButtonTarget), for: .touchUpInside)
    }
    
    @objc public func rightButtonTarget() {
      guard let vc = storyboard?.instantiateViewController(withIdentifier: "NewWriteViewController") as? NewWriteViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainInterviewViewController: UISearchBarDelegate {
    public func searchBarSetUp() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant:40).isActive = true
        leftTopButton.trailingAnchor.constraint(equalTo: searchBar.leadingAnchor,constant: -1).isActive = true
        button.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 1).isActive = true
    }
}

extension MainInterviewViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sampleSubject = ["1","2","3","4","5"]
        let box = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let button = UIButton(type: .system)
        let label = UILabel()
        
        box.addSubview(button)
        box.addSubview(label)
        
        label.text = sampleSubject[section]
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        label.frame = CGRect(x: 200, y: 0, width: 100, height: 50)
        button.backgroundColor = .systemPink
        button.setTitleColor(.black, for: .normal)
        button.setTitle(testText[section].isExpend ? "Close":"Open", for: .normal)
        button.addTarget(self, action: #selector(controlTableHeight(_:)) , for: .touchUpInside)
        
        button.tag = section
        return box
    }
    
    @objc func controlTableHeight(_ sender: UIButton) {
        let section = sender.tag
        var indexPaths = [IndexPath]()
        
        for row in testText[section].texts.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        testText[section].isExpend = !testText[section].isExpend
        if testText[section].isExpend {
            tableView.insertRows(at: indexPaths, with: .fade)
            
        }else {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
       sender.setTitle(testText[section].isExpend ? "Close":"Open", for: .normal)
    }
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return testText.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if testText[section].isExpend == false {
            return 0
        }
        return testText[section].texts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainInterviewTableCell") as? MainInterviewTableCell else { return UITableViewCell() }
        cell.textLabel?.text = testText[indexPath.section].texts[indexPath.row]
        cell.textLabel?.backgroundColor = .white
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
        case 5:
            vc.urlString = "https://nsios.tistory.com/31"
        case 6:
            vc.urlString = "http://throughkim.kr/2019/09/04/swift-singleton/"
        case 7:
            vc.urlString = "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&ved=2ahUKEwj15ufJ-bfoAhVwF6YKHS2EB1MQFjABegQIAhAB&url=https%3A%2F%2Fhojunpark.wordpress.com%2F2015%2F01%2F27%2F%25EC%258A%25A4%25EC%259C%2584%25ED%2594%2584%25ED%258A%25B8-%25ED%2595%25A8%25EC%2588%2598%25EC%259D%2598-%25EC%259E%25AC%25EC%25A3%25BC%25EA%25BE%25BC-%25EA%25B0%259C%25EC%25BF%25A8%25ED%2595%259C-inout-%25ED%258C%258C%25EB%259D%25BC%25EB%25AF%25B8%25ED%2584%25B0-%25EC%259D%25B4%25ED%2595%25B4%25ED%2595%2598%2F&usg=AOvVaw3hRmQl1HyzZ4wQP9ye0DAl"
        case 8:
            vc.urlString = "http://minsone.github.io/mac/ios/swift-generics-summary"
        case 9:
            vc.urlString = "https://gmlwjd9405.github.io/2018/09/21/rest-and-restful.html"
        case 10:
            vc.urlString = "https://jins-dev.tistory.com/entry/프로비저닝Provisioning-이란"
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
        tableView.backgroundColor = .white
        tableView.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
