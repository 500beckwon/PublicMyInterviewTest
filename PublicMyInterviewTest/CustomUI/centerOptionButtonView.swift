//
//  centerOptionButtonView.swift
//  PublicMyInterviewTest
//
//  Created by ByungHoon Ann on 2020/04/06.
//  Copyright © 2020 ByungHoon Ann. All rights reserved.
//

import Foundation
import UIKit

protocol centerOptionButtonViewDelegate {
    func lastViewAction(_ isSelected: Bool)
    func lastWriteAction(_ isSelected: Bool)
}

class centerOptionButtonView: UIView {
    var delegate: centerOptionButtonViewDelegate?
    var leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        centerViewSetp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func centerViewSetp() {
        leftButton.setTitle("조회 기록", for: .normal)
        rightButton.setTitle("작성 기록", for: .normal)
        leftButton.setTitleColor(.black, for: .normal)
        rightButton.setTitleColor(.black, for: .normal)
        
        leftButton.addTarget(self, action: #selector(lastViewButton(_:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(lastWriteButton(_:)), for: .touchUpInside)
        
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        
        leftButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        leftButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        rightButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func lastViewButton(_ sender: Any) {
        if let sender = sender as? UIButton {
            sender.isSelected = !sender.isSelected
            delegate?.lastViewAction(sender.isSelected)
        }
    }
    
    @objc func lastWriteButton(_ sender: Any) {
        if let sender = sender as? UIButton {
            sender.isSelected = !sender.isSelected
            delegate?.lastWriteAction(sender.isSelected)
        }
    }
}
