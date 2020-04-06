//
//  WriteTextView.swift
//  PublicMyInterviewTest
//
//  Created by ByungHoon Ann on 2020/03/28.
//  Copyright © 2020 ByungHoon Ann. All rights reserved.
//

import UIKit
protocol WriteTextViewDelegate {
    func dropDownPressed(string : String)
}

class WriteTextView: UIView, UITextFieldDelegate, UITextViewDelegate {
    

    var textfield = UITextField()
    var textView = UITextView()
    
    var delegate: WriteTextViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textfield.delegate = self
        textView.delegate = self
        
        textfield.placeholder = "제목"
        textView.text = "내용"
        
        textfield.backgroundColor = .yellow
        textView.backgroundColor = .orange
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(textfield)
        self.addSubview(textView)
        
        textfield.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textfield.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textfield.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textfield.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        textView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: textfield.bottomAnchor,constant: 3).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textfield.placeholder == "제목" {
            textfield.placeholder = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textfield.text else { return }
        if text.isEmpty {
            textfield.placeholder = "제목"
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "내용" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "내용" || textView.text.isEmpty {
            textView.text = "내용"
        }
    }
}
