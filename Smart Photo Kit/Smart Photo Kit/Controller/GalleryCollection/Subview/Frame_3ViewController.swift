//
//  Frame_3ViewController.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 17/01/2022.
//

import UIKit
import FMPhotoPicker
class Frame_3ViewController: UIViewController {
    @IBOutlet weak var workplaceView: UIView!
    @IBOutlet weak var img1: CustomeUIImageView!
    @IBOutlet weak var frameImage: UIImageView!
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
        var config = FMPhotoPickerConfig()
        config.selectMode = .single
        let picker = FMPhotoPickerViewController(config: config)
        picker.delegate = self
        self.present(picker, animated: true)
    }

}
//MARK: FMPhotoPickerViewControllerDelegate
extension Frame_3ViewController:FMPhotoPickerViewControllerDelegate{
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]){
        self.dismiss(animated: true, completion: nil)
        img1.image = photos.first
    }
}

