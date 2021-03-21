//
//  CompareTableViewCell.swift
//  AIATest
//
//  Created by Paras Navadiya on 21/03/21.
//

import UIKit

class CompareTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var stack3: UIStackView!

    @IBOutlet weak var date1Label: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var date3Label: UILabel!
    
    @IBOutlet weak var time1Label: UILabel!
    @IBOutlet weak var time2Label: UILabel!
    @IBOutlet weak var time3Label: UILabel!
    
    @IBOutlet weak var open1Label: UILabel!
    @IBOutlet weak var open2Label: UILabel!
    @IBOutlet weak var open3Label: UILabel!
    
    @IBOutlet weak var low1Label: UILabel!
    @IBOutlet weak var low2Label: UILabel!
    @IBOutlet weak var low3Label: UILabel!

    var details: CompareModel?{
        didSet{
            guard let data = details else {return}
            self.configView(details: data)
        }
    }
    

    func configView(details: CompareModel){
        switch details.symbols?.count ?? 0 {
        case 1:
            self.stack1.isHidden = false
            self.stack2.isHidden = true
            self.stack3.isHidden = true
            if let date = details.symbols?[0].date{
                self.date1Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "dd MMM, yyyy")
                self.time1Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "hh:mm a")
            }
            if let openText = details.symbols?[0].the1Open{
                self.open1Label.text = "Open: " + openText
            }
            if let lowText = details.symbols?[0].the3Low{
                self.low1Label.text = "Low: " + lowText
            }
           
        case 2:
            self.stack1.isHidden = false
            self.stack2.isHidden = true
            self.stack3.isHidden = false
            if let date = details.symbols?[0].date{
                self.date1Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "dd MMM, yyyy")
                self.time1Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "hh:mm a")
            }
            if let openText = details.symbols?[0].the1Open{
                self.open1Label.text = "Open: " + openText
            }
            if let lowText = details.symbols?[0].the3Low{
                self.low1Label.text = "Low: " + lowText
            }
            if let date = details.symbols?[1].date{
                self.date3Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "dd MMM, yyyy")
                self.time3Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "hh:mm a")
            }
            if let openText = details.symbols?[1].the1Open{
                self.open3Label.text = "Open: " + openText
            }
            if let lowText = details.symbols?[1].the3Low{
                self.low3Label.text = "Low: " + lowText
            }
        case 3:
            self.stack1.isHidden = false
            self.stack2.isHidden = false
            self.stack3.isHidden = false
            if let date = details.symbols?[0].date{
                self.date1Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "dd MMM, yyyy")
                self.time1Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "hh:mm a")
            }
            if let openText = details.symbols?[0].the1Open{
                self.open1Label.text = "Open: " + openText
            }
            if let lowText = details.symbols?[0].the3Low{
                self.low1Label.text = "Low: " + lowText
            }
            if let date = details.symbols?[1].date{
                self.date2Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "dd MMM, yyyy")
                self.time2Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "hh:mm a")
            }
            if let openText = details.symbols?[1].the1Open{
                self.open2Label.text = "Open: " + openText
            }
            if let lowText = details.symbols?[1].the3Low{
                self.low2Label.text = "Low: " + lowText
            }
            if let date = details.symbols?[2].date{
                self.date3Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "dd MMM, yyyy")
                self.time3Label.text = date.getDate(format: "yyyy-MM-dd HH:mm:ss").getString(format: "hh:mm a")
            }
            if let openText = details.symbols?[2].the1Open{
                self.open3Label.text = "Open: " + openText
            }
            if let lowText = details.symbols?[2].the3Low{
                self.low3Label.text = "Low: " + lowText
            }
        default:
            self.stack1.isHidden = true
            self.stack2.isHidden = true
            self.stack3.isHidden = true
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
