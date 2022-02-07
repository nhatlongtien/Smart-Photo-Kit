//
//  Frame_2ViewController.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 16/01/2022.
//

import UIKit
import FMPhotoPicker
class Frame_2ViewController: UIViewController {
    @IBOutlet weak var workplaceView: UIView!
    @IBOutlet weak var img1: CustomeUIImageView!
    @IBOutlet weak var img2: CustomeUIImageView!
    @IBOutlet weak var img3: CustomeUIImageView!
    @IBOutlet weak var frameImage: UIImageView!
    //
    enum ButtonImg{
        case img1
        case img2
        case img3
    }
    var typeButton:ButtonImg?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: UIEvent
    
    @IBAction func cancelButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonWasPressed(_ sender: Any) {
        let resultImage = workplaceView.asImage()
        let imageDataDict:[String: UIImage] = ["image": resultImage]
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constant.NOTIFI_FRAME), object: nil, userInfo: imageDataDict)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func img1WasPressed(_ sender: Any) {
        typeButton = .img1
        var config = FMPhotoPickerConfig()
        config.selectMode = .single
        let picker = FMPhotoPickerViewController(config: config)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    @IBAction func img2WasPressed(_ sender: Any) {
        typeButton = .img2
        var config = FMPhotoPickerConfig()
        config.selectMode = .single
        let picker = FMPhotoPickerViewController(config: config)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @IBAction func img3WasPressed(_ sender: Any) {
        typeButton = .img3
        var config = FMPhotoPickerConfig()
        config.selectMode = .single
        let picker = FMPhotoPickerViewController(config: config)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    
}
//MARK: FMPhotoPickerViewControllerDelegate
extension Frame_2ViewController:FMPhotoPickerViewControllerDelegate{
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]){
        self.dismiss(animated: true, completion: nil)
        if typeButton == .img1{
            img1.image = photos.first
        }else if typeButton == .img2{
            img2.image = photos.first
        }else if typeButton == .img3{
            img3.image = photos.first
        }
    }
}
