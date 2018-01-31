//
//  ViewController.swift
//  Custom Camera
//
//  Created by Mohamed on 1/31/18.
//  Copyright © 2018 Mohamed. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var captureSession = AVCaptureSession()
    
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up the capture session consists of 4 stages:
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
    }

    func setupCaptureSession(){
        // setup a session to specify the image quality and resolution we want
        
        captureSession.sessionPreset = AVCaptureSession.Preset.photo  // full photo resolution
        
    }
    
    func setupDevice(){
        // creating the neccessary capture devices
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        let devices = deviceDiscoverySession.devices //find the camera devices
        
        for device in devices{   //the front and back camera
            if device.position == AVCaptureDevice.Position.back{
                backCamera = device
            }else if device.position == AVCaptureDevice.Position.front{
                frontCamera = device
            }
        }
        
        currentCamera = backCamera // the default
    }
    
    func setupInputOutput(){
      // which take the captured devices and take them to the captured session
        
        do{
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
            
        }catch{
           print(error)
        }
    }
    
    func setupPreviewLayer(){
        // when a camera is ready create a layer to show the result on the screen
        
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
    }
    
    func startRunningCaptureSession(){
        
        captureSession.startRunning()
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
        //performSegue(withIdentifier: "showPhoto", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            let previewVC = segue.destination as! PreviewVC
            previewVC.image = self.image
        }
    }

}

extension ViewController: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(){
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhoto", sender: nil)
        }
    }
}

