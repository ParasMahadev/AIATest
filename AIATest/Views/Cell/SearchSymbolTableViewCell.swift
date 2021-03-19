//
//  SearchSymbolTableViewCell.swift
//  AIATest
//
//  Created by Paras Navadiya on 19/03/21.
//

import UIKit

class SearchSymbolTableViewCell: UITableViewCell {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var cellDetails: SymbolDetails?{
        didSet{
            self.symbolLabel.text = cellDetails?.symbol
            self.nameLabel.text = cellDetails?.name
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
