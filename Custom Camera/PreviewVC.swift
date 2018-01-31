//
//  PreviewVC.swift
//  Custom Camera
//
//  Created by Mohamed on 1/31/18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit

class PreviewVC: UIViewController {

    var image: UIImage!
    
    @IBOutlet weak var capturedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        capturedImage.image = self.image
    }

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
    }
    
    
}
