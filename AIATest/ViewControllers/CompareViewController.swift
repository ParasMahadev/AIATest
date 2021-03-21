//
//  CompareViewController.swift
//  AIATest
//
//  Created by Paras Navadiya on 21/03/21.
//

import UIKit

class CompareViewController: UIViewController {
    //MARK: Variables
    var viewModel = CompareViewModel()
    var symbolArray = [String]()
    var tableArray = [CompareModel](){
        didSet{
            if tableArray.count > 0{
                DispatchQueue.main.async {
                    self.tableView.backgroundView = UIView()
                    self.tableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    let noDataView = NoDataView(frame: self.tableView.frame)
                    noDataView.messageLabel.text = "No result found"
                    self.tableView.backgroundView = noDataView
                }
            }
        }
    }
    var symbol1Details = [IntradayData]()
    var symbol2Details = [IntradayData]()
    var symbol3Details = [IntradayData]()

    //MARK: Outltets
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var symbol1Title: UILabel!{
        didSet{
            self.configureLabel(symbolLabel: symbol1Title)
        }
    }
    @IBOutlet weak var symbol2Title: UILabel!{
        didSet{
            self.configureLabel(symbolLabel: symbol2Title)
        }
    }
    @IBOutlet weak var symbol3Title: UILabel!{
        didSet{
            self.configureLabel(symbolLabel: symbol3Title)
        }
    }
    @IBOutlet weak var close1Button: UIButton!
    @IBOutlet weak var close2Button: UIButton!
    @IBOutlet weak var close3Button: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var closeButtonCollection: [UIButton]!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureTableView()
    }
    
    //MARK: Functions
    func configureViews(){
        view3.isHidden = true
        view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(view1TappedAction(_:))))
        view2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(view2TappedAction(_:))))
        view3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(view3TappedAction(_:))))
        symbol1Title.text = "+"
        symbol2Title.text = "+"
        symbol3Title.text = "+"
        plusAndCloseButtonValidation()
    }
    
    func configureLabel(symbolLabel: UILabel){
        if let text = symbolLabel.text, text == ""{
            symbolLabel.text = "+"
        }
    }
    
    func configureTableView(){
        self.tableView.register(UINib(nibName: CellIdentifieres.CompareTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifieres.CompareTableViewCell.rawValue)
        self.tableView.tableFooterView = UIView()
    }
    
    func presentSearchSymbolViewController(index: Int){
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchVC.compareDelegate = self
        searchVC.selectionIndex = index
        self.present(searchVC, animated: true) {
            searchVC.searchTextField.becomeFirstResponder()
        }
    }
    
    func plusAndCloseButtonValidation(){
        if view1.isHidden == false && view2.isHidden == false && view3.isHidden == false{
            plusButton.isHidden = true
        }else{
            plusButton.isHidden = false
            for item in closeButtonCollection{
                item.isHidden = true
            }
        }
        configSymbolArray()
    }
    
    func viewValidation(view: UIView, closeButton: UIButton, symbolLabel: UILabel){
        view.isHidden = true
        closeButton.isHidden = true
        symbolLabel.text = "+"
        plusAndCloseButtonValidation()
    }
    
    func configSymbolArray(){
        self.symbolArray = [symbol1Title.text ?? "", symbol2Title.text ?? "", symbol3Title.text ?? ""]
        
    }
    
    func GetIntradayData(symbol: String, completion: @escaping ([IntradayData]?) -> Void)  {
        self.viewModel.getIntradayData(symbol: symbol) { (list, error) in
            if let error = error{
                DispatchQueue.main.async {
                    self.showAlert(title: "Compare", message: error)
                    return
                }
            }
            if let data = list{
                completion(data)
            }
        }
    }
    
    func configureTableArray(){
        var tampArray = [[IntradayData]]()
        if self.symbol1Details.count > 0{
            tampArray.append(self.symbol1Details)
        }
        if self.symbol2Details.count > 0{
            tampArray.append(self.symbol2Details)
        }
        if self.symbol3Details.count > 0{
            tampArray.append(self.symbol3Details)
        }
        //For checking minimum two array have more then 1 elements
        var temp = 0
        for item in tampArray{
            if item.count > 0{
                temp = temp + 1
            }
        }
        if temp < 2{
            return
        }
        //Find minimum elements from the array
        let minimumCount = tampArray.map { element in
            return element.count
        }.min()
        
        if minimumCount ?? 0 > 0{
            var array = [CompareModel]()
            for index in 0...minimumCount! - 1{
                var intradayData = [IntradayData]()
                if symbol1Details.count > 0{
                    intradayData.append(symbol1Details[index])
                }
                if symbol2Details.count > 0{
                    intradayData.append(symbol2Details[index])
                }
                if symbol3Details.count > 0{
                    intradayData.append(symbol3Details[index])
                }
                array.append(CompareModel(symbols: intradayData))
            }
            self.tableArray = array
        }
    
    }
    
    //MARK: Actions
    @objc func view1TappedAction(_ sender: UIView){
        self.presentSearchSymbolViewController(index: 1)
    }
    
    @objc func view2TappedAction(_ sender: UIView){
        self.presentSearchSymbolViewController(index: 2)
    }
    
    @objc func view3TappedAction(_ sender: UIView){
        self.presentSearchSymbolViewController(index: 3)

    }
    
    @IBAction func plusButtonAction(_ sender: UIButton){
        for item in viewCollection{
            if item.isHidden == true{
                item.isHidden = false
            }
        }
        for item in closeButtonCollection{
            if item.isHidden == true{
                item.isHidden = false
            }
        }
        plusAndCloseButtonValidation()
    }
    
    @IBAction func close1ButtonAction(_ sender: UIButton){
        self.viewValidation(view: view1, closeButton: close1Button, symbolLabel: symbol1Title)
        self.symbol1Details = [IntradayData]()
        self.configureTableArray()
    }
    
    @IBAction func close2ButtonAction(_ sender: UIButton){
        self.viewValidation(view: view2, closeButton: close2Button, symbolLabel: symbol2Title)
        self.symbol2Details = [IntradayData]()
        self.configureTableArray()
    }
    
    @IBAction func close3ButtonAction(_ sender: UIButton){
        self.viewValidation(view: view2, closeButton: close3Button, symbolLabel: symbol3Title)
        self.symbol3Details = [IntradayData]()
        self.configureTableArray()
    }
}

extension CompareViewController: ComapreViewControllerDelegate{
    func selectedSymbol(symbol: SymbolDetails, selectionIndex: Int) {
        if self.symbolArray.contains(symbol.symbol ?? ""){
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.showAlert(title: "Compare", message: "Symbol already exist")
            }
            return
        }
        guard let symbolString = symbol.symbol, symbolString != "" else{
            return
        }
        switch selectionIndex {
        case 1:
            self.symbol1Title.text = symbol.symbol
            self.GetIntradayData(symbol: symbolString) { list in
                guard let data = list else {return}
                self.symbol1Details = data
                self.configureTableArray()
            }
        case 2:
            self.symbol2Title.text = symbol.symbol
            self.GetIntradayData(symbol: symbolString) { list in
                guard let data = list else {return}
                self.symbol2Details = data
                self.configureTableArray()
            }
        case 3:
            self.symbol3Title.text = symbol.symbol
            self.GetIntradayData(symbol: symbolString) { list in
                guard let data = list else {return}
                self.symbol3Details = data
                self.configureTableArray()
            }
        default:
            break
        }
        configSymbolArray()
    }
}

extension CompareViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifieres.CompareTableViewCell.rawValue) as! CompareTableViewCell
        cell.details = tableArray[indexPath.row]
        return cell
    }
    
    
}
