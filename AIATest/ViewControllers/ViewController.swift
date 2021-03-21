//
//  ViewController.swift
//  AIATest
//
//  Created by Paras Navadiya on 18/03/21.
//

import UIKit



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
    
    //MARK: View Controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.symbolTextField.delegate = self
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchData()
    }
    
    //Fetch data
    func fetchData(){
        var symbol = "IBM"
        if let text = self.symbolTextField.text, text != ""{
            symbol = text
        }
        self.viewModel.getIntradayData(symbol: symbol) { data,errorMessage  in
            if let error = errorMessage{
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: error)
                }
                return
            }
            if let data = data{
                self.intradayData = data
                DispatchQueue.main.async {
                    self.tableView.backgroundView = UIView()
                }
            }else{
                DispatchQueue.main.async {
                    self.intradayData = [IntradayData]()
                    let noDataView = NoDataView(frame: self.tableView.frame)
                    noDataView.messageLabel.text = "No result found"
                    self.tableView.backgroundView = noDataView
                }
            }
        }
    }

    func configTableView(){
        self.tableView.register(UINib(nibName: CellIdentifieres.IntradayTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifieres.IntradayTableViewCell.rawValue)
        self.tableView.register(UINib(nibName: CellIdentifieres.IntradayHeaderTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifieres.IntradayHeaderTableViewCell.rawValue)
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.intradayData?.count ?? 0 + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifieres.IntradayHeaderTableViewCell.rawValue, for: indexPath) as! IntradayHeaderTableViewCell
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifieres.IntradayTableViewCell.rawValue, for: indexPath) as! IntradayTableViewCell
            cell.indexPath = indexPath
            cell.details = self.intradayData?[indexPath.row - 1]
            return cell
        }
    }
}

extension ViewController: IntradayHeaderTableViewCellDelegate{
    func dateAndTimeButtonAction() {
        self.intradayData = self.intradayData?.sorted(by: { (element1, element2) in
            return element1.date?.getDate(format: "yyyy-MM-dd HH:mm:ss") ?? Date() > element2.date?.getDate(format: "yyyy-MM-dd HH:mm:ss") ?? Date()
        })
    }
    
    func openButtonAction() {
        self.intradayData = self.intradayData?.sorted(by: { (element1, element2) in
            let firstValue: Double = Double(element1.the1Open ?? "") ?? 0.0
            let secondValue: Double = Double(element2.the1Open ?? "") ?? 0.0
            return firstValue > secondValue
        })
    }
    func highButtonAction() {
        self.intradayData = self.intradayData?.sorted(by: { (element1, element2) in
            let firstValue: Double = Double(element1.the2High ?? "") ?? 0.0
            let secondValue: Double = Double(element2.the2High ?? "") ?? 0.0
            return firstValue > secondValue
        })
    }
    
    func lowButtonAction() {
        self.intradayData = self.intradayData?.sorted(by: { (element1, element2) in
            let firstValue: Double = Double(element1.the3Low ?? "") ?? 0.0
            let secondValue: Double = Double(element2.the3Low ?? "") ?? 0.0
            return firstValue > secondValue
        })
    }
}


extension ViewController: UITextFieldDelegate, SearchViewControllerDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchVC.delegate = self
        self.present(searchVC, animated: true) {
            searchVC.searchTextField.becomeFirstResponder()
        }
        return false
    }
    
    func selectedSymbol(symbol: SymbolDetails) {
        if let sym = symbol.symbol{
            self.symbolTextField.text = sym
            self.fetchData()
        }
    }
}

