//
//  SearchViewController.swift
//  AIATest
//
//  Created by Paras Navadiya on 19/03/21.
//

import UIKit

protocol SearchViewControllerDelegate {
    func selectedSymbol(symbol: SymbolDetails)
}

class SearchViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultTableView: UITableView!
    //MARK: Variables
    var delegate: SearchViewControllerDelegate?
    var searchArray = [SymbolDetails](){
        didSet{
            DispatchQueue.main.async {
                self.searchResultTableView.reloadData()
            }
        }
    }
    var viewModel = SearchSymbolViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(self.textFieldEditing(_:)), for: .editingChanged)
        configTableView()
    }
    
    func configTableView(){
        self.searchResultTableView.register(UINib(nibName: CellIdentifieres.SearchSymbolTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifieres.SearchSymbolTableViewCell.rawValue)
        self.searchResultTableView.tableFooterView = UIView()
        self.searchResultTableView.separatorInset = .zero
    }
    
    //MARK: Actions
    @IBAction func dismissButtonPressed(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifieres.SearchSymbolTableViewCell.rawValue, for: indexPath) as! SearchSymbolTableViewCell
        cell.cellDetails = self.searchArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let symbol = self.searchArray[indexPath.row]
        self.delegate?.selectedSymbol(symbol: symbol)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldEditing(_ textField: UITextField){
        if let text = textField.text, text != ""{
            self.viewModel.getSymbolData(keyword: text) { searchData,errorMessage  in
                if let error = errorMessage{
                    self.showAlert(title: "Error", message: error)
                    return
                }
                if let searchData = searchData,searchData.count > 0{
                    self.searchArray = searchData
                    DispatchQueue.main.async {
                        self.searchResultTableView.backgroundView = UIView()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.searchArray = [SymbolDetails]()
                        let noDataView = NoDataView(frame: self.searchResultTableView.frame)
                        noDataView.messageLabel.text = "No search result found"
                        self.searchResultTableView.backgroundView = noDataView
                    }
                }
            }
        }
    }
}


