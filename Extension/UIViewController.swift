//
//  UIViewController.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 05/02/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Ok !", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
}
