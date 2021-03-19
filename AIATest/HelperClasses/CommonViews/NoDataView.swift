//
//  NoDataView.swift
//  AIATest
//
//  Created by Paras Navadiya on 19/03/21.
//

import UIKit

class NoDataView: UIView {

    let messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView(){
        messageLabel.frame = CGRect(x: 25, y: 30, width: self.frame.width - 50, height: 100)
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        addSubview(messageLabel)
    }
}
