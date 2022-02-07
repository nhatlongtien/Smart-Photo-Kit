//
//  Frame_4ViewController.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 17/01/2022.
//

import UIKit
import StickerView
import FMPhotoPicker
class Frame_4ViewController: UIViewController {
    @IBOutlet weak var workplaceView: UIView!
    @IBOutlet weak var toolFrameView: ToolsFrameView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var img1: CustomeUIImageView!
    @IBOutlet weak var img2: CustomeUIImageView!
    @IBOutlet weak var frameImage: UIImageView!
    //
    enum ButtonImg{
        case img1
        case img2
    }
    var typeButton:ButtonImg?
    //
    private var _selectedStickerView:StickerView?

    var selectedStickerView:StickerView? {
        get {
            return _selectedStickerView
        }
        set {
            // if other sticker choosed then resign the handler
            if _selectedStickerView != newValue {
                if let selectedStickerView = _selectedStickerView {
                    selectedStickerView.showEditingHandlers = false
                }
                _selectedStickerView = newValue
            }
            // assign handler to new sticker added
            if let selectedStickerView = _selectedStickerView {
                selectedStickerView.showEditingHandlers = true
                selectedStickerView.superview?.bringSubviewToFront(selectedStickerView)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolFrameView.delegate = self
        //
        frameImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDidTapEmptyView)))
    }
    //MARK: UIEvent
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
    
    @IBAction func cancelButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneButtonWasPressed(_ sender: Any) {
        let resultImage = workplaceView.asImage()
        let imageDataDict:[String: UIImage] = ["image": resultImage]
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constant.NOTIFI_FRAME), object: nil, userInfo: imageDataDict)
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: Helper Method
    func addStickerImageToFrameImage(image:UIImage?){
        let testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 150, height: 150))
        testImage.image = image
        testImage.contentMode = .scaleAspectFit
        let stickerView3 = StickerView.init(contentView: testImage)
        stickerView3.center = CGPoint.init(x: 150, y: 150)
        stickerView3.isUserInteractionEnabled = true
        stickerView3.delegate = self
        stickerView3.setImage(UIImage.init(named: "Close")!, forHandler: StickerViewHandler.close)
        stickerView3.setImage(UIImage.init(named: "Rotate")!, forHandler: StickerViewHandler.rotate)
        stickerView3.setImage(UIImage.init(named: "Flip")!, forHandler: StickerViewHandler.flip)
        stickerView3.showEditingHandlers = false
        stickerView3.tag = 999
        self.frameImage.addSubview(stickerView3)
        self.selectedStickerView = stickerView3
    }
    @objc func handleDidTapEmptyView(){
        selectedStickerView?.showEditingHandlers = false
    }
}
//MARK: ToolsFrameViewDelegate
extension Frame_4ViewController:ToolsFrameViewDelegate{
    func didSelectMoreSticker(sticker: [StickerModel]?) {
        let targetVC = StickerViewController()
        targetVC.sticker = sticker!
        targetVC.delegate = self
        targetVC.modalPresentationStyle = .custom
        self.present(targetVC, animated: true, completion: nil)
    }
    
    func didSelecteGeneralSticker(sticker: UIImage?) {
        addStickerImageToFrameImage(image: sticker)
    }
    
    func didFinishPickerColor(color: UIColor) {
        self.bgImage.image = UIImage(color: color, size: bgImage.bounds.size)
    }
    
    func didFinishPickerGradientColor(gradientColor: UIImage) {
        self.bgImage.image = gradientColor
    }
    
}
//MARK: FMPhotoPickerViewControllerDelegate
extension Frame_4ViewController:FMPhotoPickerViewControllerDelegate{
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]){
        self.dismiss(animated: true, completion: nil)
        if typeButton == .img1{
            img1.image = photos.first
        }else if typeButton == .img2{
            img2.image = photos.first
        }
    }
}
//MARK: StickerViewControllerDelegate
extension Frame_4ViewController:StickerViewControllerDelegate{
    func passStickerImage(sticker: UIImage?) {
        addStickerImageToFrameImage(image: sticker)
    }
}
//MARK: StickerViewDelegate
extension Frame_4ViewController:StickerViewDelegate{
    func stickerViewDidTap(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
        
    }
}
