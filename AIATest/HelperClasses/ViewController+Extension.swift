//
//  ViewController+Extension.swift
//  AIATest
//
//  Created by Paras Navadiya on 19/03/21.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showAlert(title: String,message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
