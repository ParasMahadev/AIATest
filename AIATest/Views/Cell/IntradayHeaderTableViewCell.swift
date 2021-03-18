//
//  IntradayHeaderTableViewCell.swift
//  AIATest
//
//  Created by Paras Navadiya on 19/03/21.
//

import UIKit

protocol IntradayHeaderTableViewCellDelegate {
    func dateAndTimeButtonAction()
    func openButtonAction()
    func highButtonAction()
    func lowButtonAction()
}

class IntradayHeaderTableViewCell: UITableViewCell {

    var delegate: IntradayHeaderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func dateAndTimeButtonAction(_ sender: UIButton){
        self.delegate?.dateAndTimeButtonAction()
    }
    
    @IBAction func openButtonAction(_ sender: UIButton){
        self.delegate?.openButtonAction()
    }
    
    @IBAction func highButtonAction(_ sender: UIButton){
        self.delegate?.highButtonAction()
    }
    
    @IBAction func lowButtonAction(_ sender: UIButton){
        self.delegate?.lowButtonAction()
    }
    
}
