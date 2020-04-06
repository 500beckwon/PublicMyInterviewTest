//
//  AttachURLView.swift
//  PublicMyInterviewTest
//
//  Created by ByungHoon Ann on 2020/03/31.
//  Copyright © 2020 ByungHoon Ann. All rights reserved.
//

import UIKit
import WebKit

protocol AttachURLViewDelegate {
    func okButtonIsSelected(_ isSelected: Bool)
}

class AttachURLView: UIView {
    var delegate: AttachURLViewDelegate?
    var wkWebView: WKWebView = {
        let wkWebView = WKWebView()
        wkWebView.translatesAutoresizingMaskIntoConstraints = false        
        return wkWebView
    }()
    
    var okButton: UIButton = {
        let button = UIButton(type:.system)
        button.setTitle("작성", for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .yellow
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
        self.alpha = 0.0
        okButtonSetUp()
        webkitViewSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func webkitViewSetUp() {
        self.addSubview(wkWebView)
        wkWebView.topAnchor.constraint(equalTo: okButton.bottomAnchor).isActive = true
        wkWebView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        wkWebView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 1).isActive = true
        wkWebView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -1).isActive = true
    }
    
    func okButtonSetUp() {
        self.addSubview(okButton)
        okButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        okButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20).isActive = true
        okButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        okButton.addTarget(self, action: #selector(okButtonEvent(_:)), for: .touchUpInside)
    }
    
    @objc func okButtonEvent(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.isSelected = true
        }else {
            sender.isSelected = false
        }
        delegate?.okButtonIsSelected(sender.isSelected)
        print("asdf")
            // delegate?.okButtonIsSelected(sender.isSelected)
    }
}
