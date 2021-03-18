//
//  ViewController.swift
//  AIATest
//
//  Created by Paras Navadiya on 18/03/21.
//

import UIKit

enum CellIdentifieres: String {
    case IntradayTableViewCell = "IntradayTableViewCell"
}

class ViewController: UIViewController {
    //MARK: Variables
    var viewModel = SymbolViewModel()
    var intradayData: intradayDataList?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    //MARK:Outlets
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var symbol = "IBM"
        if let text = self.symbolTextField.text, text != ""{
            symbol = text
        }
        self.viewModel.getDataIntradayData(timeInterval: .fifteenMin, symbol: symbol) { data in
            if let data = data{
                self.intradayData = data
            }
        }
    }

    func configTableView(){
        self.tableView.register(UINib(nibName: CellIdentifieres.IntradayTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifieres.IntradayTableViewCell.rawValue)
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.intradayData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifieres.IntradayTableViewCell.rawValue, for: indexPath) as! IntradayTableViewCell
        cell.indexPath = indexPath
        cell.details = self.intradayData?[indexPath.row]
        return cell
    }
    
    
}
