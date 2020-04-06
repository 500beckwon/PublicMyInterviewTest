//
//  NewWriteViewController.swift
//  PublicMyInterviewTest
//
//  Created by ByungHoon Ann on 2020/03/27.
//  Copyright © 2020 ByungHoon Ann. All rights reserved.
//

import UIKit
import WebKit

final class NewWriteViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,AttachURLViewDelegate, centerOptionButtonViewDelegate {
    
    var urlString = ""
    var sampleTexts = ["URL(인터넷 주소)","직접 작성","이미지만 첨부","촬영하기"]
    let collectionSample = [UIColor.black,
                            UIColor.white,
                            UIColor.red,
                            UIColor.systemBlue,
                            UIColor.systemPink,
                            UIColor.green,
                            UIColor.green,
                            UIColor.yellow,
                            UIColor.purple,
                            UIColor.brown]
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "문서에 첨부할 내용의 유형을 선택해주세요"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let alert = UIAlertController(title: "안내", message: "", preferredStyle: .alert)
    lazy var rightButton: UIBarButtonItem = {
        let barbutton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(sendReportButton(_:)))
        return barbutton
    }()
    
    public var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.isDirectionalLockEnabled = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    public var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionViewLayout.scrollDirection = .vertical
        collectionView.backgroundColor = .white
        return collectionView
    }()

    public var customWebKitView = AttachURLView()
    public var writeView = WriteTextView()
    public var centerOptionView = centerOptionButtonView()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewHideGesture(_:)))
        topLabel.addGestureRecognizer(gesture)
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "작성"
        navigationItem.rightBarButtonItem = rightButton
        
        topLabelSetUp()
        tableViewSetUp()
        centerViewSetp()
        collectionViewSetUp()
        writeViewSetUp()
        websetUp()
    }
    
    @objc public func sendReportButton(_ sender: Any) {
        if sender is UIBarButtonItem {
            //guard let subject = textfield.text else { return }
           // guard let body = textView.text else { return }
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainInterviewViewController") as? MainInterviewViewController else { return }
          //  vc.testTexts.append(subject)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    public func loadUrl() {
        guard !urlString.isEmpty else { return }
        guard let url = URL(string: "\(urlString)") else { return }
        let requeset = URLRequest(url: url)
        customWebKitView.wkWebView.load(requeset)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleTexts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewWriteTableViewCell") as? NewWriteTableViewCell else { return UITableViewCell() }
        cell.label.text = sampleTexts[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/4
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            alert.addTextField { tf in
                tf.delegate = self
            }
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
        }
        if indexPath.row == 1 {
            tableView.isHidden = true
            writeView.isHidden = false
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
                self.writeView.alpha = 1.0
            },completion: nil)
        }
    }
    
    public func centerViewSetp() {
        view.addSubview(centerOptionView)
        centerOptionView.delegate = self
        centerOptionView.translatesAutoresizingMaskIntoConstraints = false
        centerOptionView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 1).isActive = true
        centerOptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1).isActive = true
        centerOptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1).isActive = true
        centerOptionView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    public func collectionViewSetUp() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nibName = UINib(nibName: "NewWriteCollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "NewWriteCollectionViewCell")
        collectionView.topAnchor.constraint(equalTo: centerOptionView.bottomAnchor,constant: 1).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 1).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -1).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func viewHideGesture(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 1,delay: 0,options: .curveEaseIn, animations: {
            self.writeView.alpha = 0
        }) { check in
            if check == true {
                self.tableView.isHidden = false
                self.writeView.isHidden = true
            }
        }
    }
    
    func lastViewAction(_ isSelected: Bool) {
        print(isSelected)
    }
    
    func lastWriteAction(_ isSelected: Bool) {
        print(isSelected)
    }
    
    func okButtonIsSelected(_ isSelected: Bool) {
        print(isSelected)
    }
}

extension NewWriteViewController: UITextViewDelegate {
    
}

extension NewWriteViewController: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == writeView.textfield {
            
        } else {
            
            guard let texte = textField.text else  { return }
            if texte.verifyUrl(urlString: texte) == true {
                print("url checking did")
                urlString = texte
                tableView.isHidden = true
                customWebKitView.isHidden = false
                customWebKitView.alpha = 1
                alert.dismiss(animated: true)
                loadUrl()
            }else {
                print("url fale")
            }
        }
    }
}

extension String {
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
