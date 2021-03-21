//
//  SettingViewController.swift
//  AIATest
//
//  Created by Paras Navadiya on 20/03/21.
//

import UIKit

class SettingViewController: UIViewController {
    
    //MARK:Outlets
    @IBOutlet weak var apiKeyTextField: UITextField!
    @IBOutlet weak var outputSizeSegment: UISegmentedControl!
    @IBOutlet weak var timeIntervalSegment: UISegmentedControl!

    //MARK: Variables
    var viewModel = SettingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureSegment()
        //APIKey
        self.apiKeyTextField.delegate = self
        self.apiKeyTextField.text = Constants.shared.getStringFromKeyChain(key: "APIKey")
    }
    
    func configureSegment(){
        //Time Interval
        self.timeIntervalSegment.selectedSegmentIndex = viewModel.getTimeIntervalIndex()
        //Output Size
        self.outputSizeSegment.selectedSegmentIndex = viewModel.getOutputsizeIndex()
    }
    
    
    //MARK: Actions
    @IBAction func segementControllerAction(_ sender: UISegmentedControl){
        if sender == self.outputSizeSegment{
            Constants.shared.setStringToUserDefaults(key: .outputsize, value: viewModel.getOutputsize(index: sender.selectedSegmentIndex).rawValue)
        }
        if sender == self.timeIntervalSegment{
            Constants.shared.setStringToUserDefaults(key: .intarval, value: viewModel.getTimeInterval(index: sender.selectedSegmentIndex).rawValue)
        }
    }

}

extension SettingViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text != ""{
            Constants.shared.storeStringToKeyChain(key: "APIKey", value: text)
        }else{
            self.showAlert(title: "Setting", message: "Please enter APIKey")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
