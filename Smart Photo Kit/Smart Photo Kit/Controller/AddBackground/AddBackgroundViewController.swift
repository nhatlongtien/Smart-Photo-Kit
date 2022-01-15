//
//  AddBackgroundViewController.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 30/12/2021.
//

import UIKit
import TCMask
import StickerView
import SnapKit
import Kingfisher
import FMPhotoPicker
protocol AddBackgroundViewControllerDelegate:class{
    func didFinshDesign(image:UIImage?)
}
class AddBackgroundViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var gradientCollectionView: UICollectionView!
    @IBOutlet weak var stickerCollectionView: UICollectionView!
    @IBOutlet weak var ratioScreenCollectionView: UICollectionView!
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var verticalView: UIView!
    @IBOutlet weak var containerView: UIView!
    //
    var image:UIImage?
    let colors = Array(ColorModel.shareColor().reversed())
    let gradientColorImgs = GradientColorModel.share()
    let frameImgs = FrameModel.share()
    let verticalScreen = RatioScreenModel.shareRatioVerticalScreen()
    let horizontalScreen = RatioScreenModel.shareRatioHorizontalScreen()
    var isHorizontalScreen:Bool = true
    weak var delegate:AddBackgroundViewControllerDelegate?
    let stickerVM = StickerViewModel()
    var sticker:[StickerModel] = []
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
    //MARK: UIView Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelDidTapImageView)))
        //
        horizontalView.layer.borderColor = UIColor.gold.cgColor
        horizontalView.layer.borderWidth = 2.0
        //self.imageView.image = image
        //TODO: Config colorCollectionView
        let colorLayout = UICollectionViewFlowLayout()
        colorLayout.scrollDirection = .horizontal
        colorLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        colorCollectionView.collectionViewLayout = colorLayout
        let colorNibCell = UINib(nibName: "TextColorCollectionViewCell", bundle: nil)
        colorCollectionView.register(colorNibCell, forCellWithReuseIdentifier: "TextColorCollectionViewCell")
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        //TODO: Config gradientColorCollectionview
        let gradientLayout = UICollectionViewFlowLayout()
        gradientLayout.scrollDirection = .horizontal
        gradientLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        gradientCollectionView.collectionViewLayout = gradientLayout
        let gradientColorNibCell = UINib(nibName: "GradientColorCollectionViewCell", bundle: nil)
        gradientCollectionView.register(gradientColorNibCell, forCellWithReuseIdentifier: "GradientColorCollectionViewCell")
        gradientCollectionView.delegate = self
        gradientCollectionView.dataSource = self
        //TODO: config stickerCollectionView
        let frameLayout = UICollectionViewFlowLayout()
        frameLayout.scrollDirection = .horizontal
        frameLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stickerCollectionView.collectionViewLayout = frameLayout
        let frameNibCell = UINib(nibName: "GradientColorCollectionViewCell", bundle: nil)
        stickerCollectionView.register(frameNibCell, forCellWithReuseIdentifier: "GradientColorCollectionViewCell")
        stickerCollectionView.delegate = self
        stickerCollectionView.dataSource = self
        //TODO: config ratioScreenCollectionView
        let ratioLayout = UICollectionViewFlowLayout()
        ratioLayout.scrollDirection = .horizontal
        ratioLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        ratioScreenCollectionView.collectionViewLayout = ratioLayout
        let ratioNibCell = UINib(nibName: "RatioScreenCollectionViewCell", bundle: nil)
        ratioScreenCollectionView.register(ratioNibCell, forCellWithReuseIdentifier: "RatioScreenCollectionViewCell")
        ratioScreenCollectionView.delegate = self
        ratioScreenCollectionView.dataSource = self
        //
        if image != nil{
            addStickerImageToImageView(image: image)
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        setupSquareImageView()
        imageView.image = gradientColorImgs.first
        imageView.contentMode = .scaleAspectFill
        //
        stickerVM.getSticker { success, sticker in
            if success{
                self.sticker = sticker ?? []
                self.stickerCollectionView.reloadData()
            }
        }
    }
    //MARK: UI Event
    @IBAction func selectPhotoButtonWasPressed(_ sender: Any) {
        var config = FMPhotoPickerConfig()
        config.selectMode = .single
        let picker = FMPhotoPickerViewController(config: config)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    @IBAction func verticalRatioScreenButtonWasPressed(_ sender: Any) {
        isHorizontalScreen = false
        verticalView.layer.borderColor = UIColor.gold.cgColor
        verticalView.layer.borderWidth = 2.0
        horizontalView.layer.borderColor = UIColor.clear.cgColor
        horizontalView.layer.borderWidth = 0
        ratioScreenCollectionView.reloadData()
    }
    @IBAction func horizontalRatioScreenButtonWasPressed(_ sender: Any) {
        isHorizontalScreen = true
        horizontalView.layer.borderColor = UIColor.gold.cgColor
        horizontalView.layer.borderWidth = 2.0
        verticalView.layer.borderColor = UIColor.clear.cgColor
        verticalView.layer.borderWidth = 0
        ratioScreenCollectionView.reloadData()
    }
    @IBAction func cancelButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    @IBAction func doneButtonWasPressed(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.delegate?.didFinshDesign(image: img)
        self.dismiss(animated: true)
    }
    
    @IBAction func clearBackgoundColorButtonWasPressed(_ sender: Any) {
        imageView.backgroundColor = .clear
        imageView.image = nil
    }
    @IBAction func clearGradientColorButtonWasPressed(_ sender: Any) {
        imageView.backgroundColor = .clear
        imageView.image = nil
    }
    
    @objc func handelDidTapImageView(){
        selectedStickerView?.showEditingHandlers = false
    }
    //MARK: Helper Method
    func addStickerImageToImageView(image:UIImage?){
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
        self.imageView.addSubview(stickerView3)
        self.selectedStickerView = stickerView3
    }
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
    //
    func mergeTwoImage(backgroundImage:UIImage, foregroundImage:UIImage, alpha:CGFloat){
        let size = CGSize(width: backgroundImage.size.width, height: backgroundImage.size.height)
        UIGraphicsBeginImageContext(size)
        let area = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        backgroundImage.draw(in: area)
        foregroundImage.draw(in: area, blendMode: .normal, alpha: alpha)
        var finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = finalImage
    }
    //
    func setupImageView(ratio:CGFloat){
        if isHorizontalScreen == true{
            imageView.removeFromSuperview()
            imageView.snp.removeConstraints()
            containerView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(15)
                make.bottom.equalToSuperview().offset(-15)
                make.centerX.centerY.equalToSuperview()
                make.width.equalTo(imageView.snp.height).multipliedBy(ratio)
            }
        }else{
            imageView.removeFromSuperview()
            imageView.snp.removeConstraints()
            containerView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(15)
                make.right.equalToSuperview().offset(-15)
                make.centerX.centerY.equalToSuperview()
                make.height.equalTo(imageView.snp.width).multipliedBy(ratio)
            }
        }
        print(containerView.bounds.size)
        
    }
    func setupSquareImageView(){
        imageView.removeFromSuperview()
        imageView.snp.removeConstraints()
        containerView.addSubview(imageView)
        if containerView.bounds.size.width >= containerView.bounds.size.height{
            imageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(15)
                make.bottom.equalToSuperview().offset(-15)
                make.centerX.centerY.equalToSuperview()
                make.width.equalTo(imageView.snp.height).multipliedBy(1)
            }
        }else{
            imageView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(15)
                make.right.equalToSuperview().offset(-15)
                make.centerX.centerY.equalToSuperview()
                make.height.equalTo(imageView.snp.width).multipliedBy(1)
            }
        }
    }
    
    
}
//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension AddBackgroundViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorCollectionView{
            return colors.count
        }else if collectionView == gradientCollectionView{
            return gradientColorImgs.count
        }else if collectionView == stickerCollectionView{
            guard let generalSticker = sticker.first else {return 0}
            if  generalSticker.listItem.count > 10{
                return 11
            }else{
                return generalSticker.listItem.count
            }
            
        }else if collectionView == ratioScreenCollectionView{
            if isHorizontalScreen == true{
                return horizontalScreen.count
            }else{
                return verticalScreen.count
            }
            
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colorCollectionView{
            let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: "TextColorCollectionViewCell", for: indexPath) as! TextColorCollectionViewCell
            cell.colorView.layer.cornerRadius = 10
            cell.colorView.clipsToBounds = true
            cell.configCell(item: colors[indexPath.row])
            return cell
        }else if collectionView == gradientCollectionView{
            let cell = gradientCollectionView.dequeueReusableCell(withReuseIdentifier: "GradientColorCollectionViewCell", for: indexPath) as! GradientColorCollectionViewCell
            cell.configCell(item: gradientColorImgs[indexPath.row])
            return cell
        }else if collectionView == stickerCollectionView{
            let cell = stickerCollectionView.dequeueReusableCell(withReuseIdentifier: "GradientColorCollectionViewCell", for: indexPath) as! GradientColorCollectionViewCell
            cell.imageView.contentMode = .scaleAspectFit
            if indexPath.row == 10{
                cell.imageView.image = UIImage(named: "more_icon")
            }else{
                let imageUrl = URL(string: (sticker.first?.listItem[indexPath.row])!)
                cell.imageView.kf.setImage(with: imageUrl)
            }
            return cell
        }else if collectionView == ratioScreenCollectionView{
            let cell = ratioScreenCollectionView.dequeueReusableCell(withReuseIdentifier: "RatioScreenCollectionViewCell", for: indexPath) as! RatioScreenCollectionViewCell
            if isHorizontalScreen == true{
                cell.configCell(item: horizontalScreen[indexPath.row])
            }else{
                cell.configCell(item: verticalScreen[indexPath.row])
            }
            return cell
            
        }else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == colorCollectionView{
            return CGSize(width: 80, height: 60)
        }else if collectionView == gradientCollectionView{
            return CGSize(width: 80, height: 60)
        }else if collectionView == stickerCollectionView{
            return CGSize(width: 80, height: 60)
        }else if collectionView == ratioScreenCollectionView{
            return CGSize(width: 70, height: 35)
        }else{
            return CGSize()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colorCollectionView{
            //self.imageView.image = UIImage(color: colors[indexPath.row], size: imageView.bounds.size)!
            self.imageView.image = nil
            self.imageView.backgroundColor = colors[indexPath.row]
        }else if collectionView == gradientCollectionView{
            self.imageView.image = gradientColorImgs[indexPath.row]
            self.imageView.contentMode = .scaleToFill
        }else if collectionView == stickerCollectionView{
            if indexPath.row == 10{
                print("More sticker image")
                let targetVC = StickerViewController()
                targetVC.sticker = self.sticker
                targetVC.delegate = self
                targetVC.modalPresentationStyle = .fullScreen
                self.present(targetVC, animated: true, completion: nil)
            }else{
                let testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 150, height: 150))
                let imageUrl = URL(string: (sticker.first?.listItem[indexPath.row])!)
                testImage.kf.setImage(with: imageUrl)
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
                self.imageView.addSubview(stickerView3)
                self.selectedStickerView = stickerView3
            }
            
        }else if collectionView == ratioScreenCollectionView{
            if isHorizontalScreen == true{
                switch horizontalScreen[indexPath.row] {
                case "SQUARE":
                    setupSquareImageView()
                case "9:16":
                    setupImageView(ratio: 9/16)
                case "8:10":
                    setupImageView(ratio: 8/10)
                case "5:7":
                    setupImageView(ratio: 5/7)
                case "3:4":
                    setupImageView(ratio: 3/4)
                case "3:5":
                    setupImageView(ratio: 3/5)
                case "2:3":
                    setupImageView(ratio: 2/3)
                default:
                    break
                }
            }else{
                switch verticalScreen[indexPath.row] {
                case "SQUARE":
                    setupSquareImageView()
                case "16:9":
                    setupImageView(ratio: 9/16)
                case "10:8":
                    setupImageView(ratio: 8/10)
                case "7:5":
                    setupImageView(ratio: 5/7)
                case "4:3":
                    setupImageView(ratio: 3/4)
                case "5:3":
                    setupImageView(ratio: 3/5)
                case "3:2":
                    setupImageView(ratio: 2/3)
                default:
                    break
                }
            }
        }
    }
}
//MARK: StickerViewDelegate
extension AddBackgroundViewController:StickerViewDelegate{
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
//MARK: StickerViewControllerDelegate
extension AddBackgroundViewController:StickerViewControllerDelegate{
    func passStickerImage(sticker: UIImage?) {
        self.addStickerImageToImageView(image: sticker)
    }
}
//MARK: FMPhotoPickerViewControllerDelegate
extension AddBackgroundViewController:FMPhotoPickerViewControllerDelegate{
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]){
        self.dismiss(animated: true, completion: nil)
        addStickerImageToImageView(image: photos.first)
    }
}

