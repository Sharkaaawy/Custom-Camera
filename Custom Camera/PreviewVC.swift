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
        UIImageWriteToSavedPhotosAlbum(capturedImage.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let errorAlert = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(errorAlert, animated: true)
        } else {
            let successAlert = UIAlertController(title: "Saved!", message: "Your captured image has been saved to your photos.", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(successAlert, animated: true)
        }
    }
    
}
