//
//  BaseViewController.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 01/01/2022.
//

import UIKit

class BaseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: Helper Method
    func saveImageToAllbum(with image:UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("ERROR: \(error)")
        }
        else {
            self.showAlert("Image saved", message: "The iamge is saved into your Photo Library.")
        }
    }
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //
    @objc func accessCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let camera = UIImagePickerController()
            camera.delegate = self
            camera.sourceType = .camera
            self.present(camera, animated: true, completion: nil)
        }else{
            print("Camera is not available")
        }
    }
}
