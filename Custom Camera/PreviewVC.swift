//
//  PreviewVC.swift
//  Custom Camera
//
//  Created by Mohamed on 1/31/18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit

class PreviewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
    }
    
    
}
