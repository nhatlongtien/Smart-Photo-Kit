//
//  CreateGalleryCollectionViewController.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 30/12/2021.
//

import UIKit
import TCMask
import StickerView
class CreateGalleryCollectionViewController: UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var frameCollectionView: UICollectionView!
    //
    var image:UIImage?
    let colors = Array(ColorModel.shareColor().reversed())
    let gradientColorImgs = GradientColorModel.share()
    let frameImgs = FrameModel.share()
    var frameName:String = "frame_1"
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
        //TODO: config frameCollectionview
        let frameLayout = UICollectionViewFlowLayout()
        frameLayout.scrollDirection = .horizontal
        frameLayout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        frameCollectionView.collectionViewLayout = frameLayout
        let frameNibCell = UINib(nibName: "GradientColorCollectionViewCell", bundle: nil)
        frameCollectionView.register(frameNibCell, forCellWithReuseIdentifier: "GradientColorCollectionViewCell")
        frameCollectionView.delegate = self
        frameCollectionView.dataSource = self
        //
        addFrameVC(vc: Frame_1ViewController())
    }
    
    //MARK: Helper Method
    func getArrayOfBytesFromImage(imageData:NSData) -> Array<UInt8>{
        
        // the number of elements:
        let count = imageData.length / MemoryLayout<Int8>.size
        
        // create array of appropriate length:
        var bytes = [UInt8](repeating: 0, count: count)
        
        // copy bytes into array
        imageData.getBytes(&bytes, length:count * MemoryLayout<Int8>.size)
        
        var byteArray:Array = Array<UInt8>()
        
        for i in 0 ..< count {
            byteArray.append(bytes[i])
        }
        return byteArray
    }
    func addFrameVC(vc:UIViewController){
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        //
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
    }
}
extension CreateGalleryCollectionViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameImgs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = frameCollectionView.dequeueReusableCell(withReuseIdentifier: "GradientColorCollectionViewCell", for: indexPath) as! GradientColorCollectionViewCell
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageView.layer.borderColor = UIColor.darkGoldenRod.cgColor
        cell.imageView.layer.borderWidth = 1
        cell.configCell(item: frameImgs[indexPath.row].illustrateImage)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 50)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        switch frameImgs[indexPath.row].frameViewName {
        case "frame_1":
            addFrameVC(vc: Frame_1ViewController())
        case "frame_2":
            addFrameVC(vc: Frame_2ViewController())
        case "frame_3":
            addFrameVC(vc: Frame_3ViewController())
        case "frame_4":
            addFrameVC(vc: Frame_4ViewController())
        case "frame_5":
            addFrameVC(vc: Frame_5ViewController())
        case "frame_6":
            addFrameVC(vc: Frame_6ViewController())
        case "frame_7":
            addFrameVC(vc: Frame_7ViewController())
        case "frame_8":
            addFrameVC(vc: Frame_8ViewController())
        case "frame_9":
            addFrameVC(vc: Frame_9ViewController())
        default:
            break
        }
    }
}
//MARK: StickerViewDelegate
extension CreateGalleryCollectionViewController:StickerViewDelegate{
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

