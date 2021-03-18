//
//  IntradayTableViewCell.swift
//  AIATest
//
//  Created by Paras Navadiya on 18/03/21.
//

import UIKit

class IntradayTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    
    //MARK: Variabals
    var indexPath: IndexPath?
    var details: IntradayData?{
        didSet{
            dateAndTimeLabel.text = details?.date
            highLabel.text = details?.the2High
            lowLabel.text = details?.the3Low
            openLabel.text = details?.the1Open
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
