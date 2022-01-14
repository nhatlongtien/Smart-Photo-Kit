//
//  Frame_1ViewController.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 01/01/2022.
//

import UIKit

class Frame_1ViewController: BaseViewController {
    
    @IBOutlet weak var workplaceView: UIView!
    @IBOutlet weak var toolFrameView: ToolsFrameView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var img1: CustomeUIImageView!
    @IBOutlet weak var img2: CustomeUIImageView!
    @IBOutlet weak var img3: CustomeUIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        toolFrameView.delegate = self
    }
    
    
    @IBAction func img1WasPressed(_ sender: Any) {
        img1.image = UIImage(named: "exemple_img")
    }
    @IBAction func img2WasPressed(_ sender: Any) {
        img2.image = UIImage(named: "exemple_img")
    }
    
    @IBAction func img3WasPressed(_ sender: Any) {
        img3.image = UIImage(named: "exemple_img")
    }
    @IBAction func cancelButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonWasPressed(_ sender: Any) {
        let resultImage = workplaceView.asImage()
        
        //saveImageToAllbum(with: resultImage)
    }
    //MARK: Helper Method
}
extension Frame_1ViewController:ToolsFrameViewDelegate{
    func didFinishPickerColor(color: UIColor) {
        self.bgImage.image = UIImage(color: color, size: bgImage.bounds.size)
    }
    
    func didFinishPickerGradientColor(gradientColor: UIImage) {
        self.bgImage.image = gradientColor
    }
    
    
}

