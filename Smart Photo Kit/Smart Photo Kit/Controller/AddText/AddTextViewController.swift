//
//  AddTextViewController.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 28/12/2021.
//

import UIKit
import JLStickerTextView
import SnapKit
import TCMask
protocol AddTextViewControllerDelegate:class{
    func didFinishAddTextInImage(image:UIImage?)
}
class AddTextViewController: UIViewController {
    
    
    @IBOutlet weak var dynamicBottomView: UIView!
    @IBOutlet weak var mainImageView: JLStickerImageView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    //
    @IBOutlet weak var heightImgConstant: NSLayoutConstraint!
    @IBOutlet weak var widthImgConstant: NSLayoutConstraint!
    @IBOutlet weak var containerImageView: UIView!
    //
    let textColorView = TextColorView()
    let textSizeView = TextSizeView()
    let shadowTextView = ShadowTextView()
    let fontTextView = FontTextView()
    //
    var selectedImg:UIImage?
    let menus = AddTextmenuButton.share()
    //
    var widthShadow:CGFloat = 0.0
    var heightShadow:CGFloat = 0.0
    var blurShadow:CGFloat = 0.0
    var colorShadow:UIColor = .gray
    //
    weak var delegate:AddTextViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        heightImgConstant.constant = containerImageView.frame.size.height
        widthImgConstant.constant = containerImageView.frame.size.width
        
        self.mainImageView.image = selectedImg
        view.layoutIfNeeded()
        self.fitAspectFitImageView()
        //
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        menuCollectionView.collectionViewLayout = layout
        let nibCell = UINib(nibName: "MenuButtonAddTextCollectionViewCell", bundle: nil)
        menuCollectionView.register(nibCell, forCellWithReuseIdentifier: "MenuButtonAddTextCollectionViewCell")
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        //
        textColorView.delegate = self
        textSizeView.delegate = self
        shadowTextView.delegate = self
        fontTextView.delegate = self
    }
    @IBAction func cancelButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneButtonWasPressed(_ sender: Any) {
        //
        let image = mainImageView.renderContentOnView()
        self.delegate?.didFinishAddTextInImage(image: image)
        self.dismiss(animated: true, completion: nil)
        //UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
    }
    //MARK: Helper Method
    func calculateRectOfImageInImageView(imageView: UIImageView) -> CGRect {
        let imageViewSize = imageView.frame.size
        let imgSize = imageView.image?.size
        
        guard let imageSize = imgSize else {
            return CGRect.zero
        }
        
        let scaleWidth = imageViewSize.width / imageSize.width
        let scaleHeight = imageViewSize.height / imageSize.height
        let aspect = fmin(scaleWidth, scaleHeight)
        
        var imageRect = CGRect(x: 0, y: 0, width: imageSize.width * aspect, height: imageSize.height * aspect)
        // Center image
        imageRect.origin.x = (imageViewSize.width - imageRect.size.width) / 2
        imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2
        
        // Add imageView offset
        imageRect.origin.x += imageView.frame.origin.x
        imageRect.origin.y += imageView.frame.origin.y
        
        return imageRect
    }
    func adjustsWidthToFillItsContens(_ view: JLStickerLabelView) {
        guard let labelTextView = view.labelTextView else {
            return
        }
        
        let attributedText = labelTextView.attributedText
        
        let recSize = attributedText?.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let w1 = (ceilf(Float((recSize?.size.width)!)) + 24 < 50) ? 50 : CGFloat(ceilf(Float((recSize?.size.width)!)) + 24)
        let h1 = (ceilf(Float((recSize?.size.height)!)) + 24 < 50) ? 50 : CGFloat(ceilf(Float((recSize?.size.height)!)) + 24)
        
        var viewFrame = view.bounds
        viewFrame.size.width = w1 + 24
        viewFrame.size.height = h1 + 18
        view.bounds = viewFrame
    }
    func setShadow(widthShadow:CGFloat, heightShadow:CGFloat, blurShadow:CGFloat, colorShadow:UIColor){
        if mainImageView.currentlyEditingLabel != nil{
            mainImageView.currentlyEditingLabel.labelTextView?.textShadowOffset = CGSize(width: widthShadow, height: heightShadow)
            mainImageView.currentlyEditingLabel.labelTextView?.textShadowColor = colorShadow
            mainImageView.currentlyEditingLabel.labelTextView?.textShadowBlur = blurShadow
        }
    }
    //
    private func fitAspectFitImageView(){
        //
        if mainImageView.contentClippingRect.height ==  mainImageView.contentClippingRect.width{ //Square condition
            if containerImageView.frame.size.width <= containerImageView.frame.size.height{
                heightImgConstant.constant = containerImageView.frame.size.width
                widthImgConstant.constant = containerImageView.frame.size.width
            }else{
                heightImgConstant.constant = containerImageView.frame.size.height
                widthImgConstant.constant = containerImageView.frame.size.height
            }
        }else{ //width of image is grater than width of contaner image
            if mainImageView.contentClippingRect.width > containerImageView.frame.size.width{
                let ratio = mainImageView.contentClippingRect.width / containerImageView.frame.size.width
                heightImgConstant.constant = mainImageView.contentClippingRect.height / ratio
                widthImgConstant.constant = mainImageView.contentClippingRect.width / ratio
            }else{
                heightImgConstant.constant = mainImageView.contentClippingRect.height
                widthImgConstant.constant = mainImageView.contentClippingRect.width
            }
        }
    }
}
extension AddTextViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "MenuButtonAddTextCollectionViewCell", for: indexPath) as! MenuButtonAddTextCollectionViewCell
        cell.configCell(item: menus[indexPath.row])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            addTextBox()
        case 1:
            if mainImageView.currentlyEditingLabel != nil{
                setupTextColorView()
            }
        case 2:
            if mainImageView.currentlyEditingLabel != nil{
                setupTextSizeView()
            }
        case 3:
            print("Font Style")
            if mainImageView.currentlyEditingLabel != nil{
                setupFontTextView()
            }
        case 4:
            if mainImageView.currentlyEditingLabel != nil{
                setupShadowTextView()
            }
        default:
            break
        }
    }
    
}
//MARK: Helper Method
extension AddTextViewController{
    private func addTextBox(){
        //Add the label
        mainImageView.addLabel()
        //Modify the label
        mainImageView.textColor = UIColor.white
        mainImageView.textAlpha = 1
        mainImageView.currentlyEditingLabel.labelTextView?.fontSize = 20
        mainImageView.currentlyEditingLabel.closeView!.image = UIImage(named: "cancel")
        mainImageView.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate-option")
        mainImageView.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
        mainImageView.currentlyEditingLabel.labelTextView?.font = UIFont.systemFont(ofSize: 20.0)
        mainImageView.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
    }
    private func setupTextColorView(){
        dynamicBottomView.addSubview(textColorView)
        textColorView.frame = dynamicBottomView.bounds
    }
    private func setupTextSizeView(){
        dynamicBottomView.addSubview(textSizeView)
        textSizeView.frame = dynamicBottomView.bounds
    }
    private func setupShadowTextView(){
        dynamicBottomView.addSubview(shadowTextView)
        shadowTextView.frame = dynamicBottomView.bounds
    }
    private func setupFontTextView(){
        dynamicBottomView.addSubview(fontTextView)
        fontTextView.frame = dynamicBottomView.bounds
    }
}
//MARK: TextColorViewDelegate
extension AddTextViewController:TextColorViewDelegate{
    func didTapCloseTextColorButton() {
        self.textColorView.removeFromSuperview()
    }
    func didFinishPickColor(color: UIColor?) {
        if mainImageView.currentlyEditingLabel != nil{
            mainImageView.textColor = color
        }
    }
}
//MARK: TextSizeViewDelegate
extension AddTextViewController:TextSizeViewDelegate{
    func didCloseButtonTextSizeViewWasPressed() {
        self.textSizeView.removeFromSuperview()
    }
    
    func textSizeSliderDidChange(value: Float?) {
        if mainImageView.currentlyEditingLabel != nil{
            mainImageView.currentlyEditingLabel.labelTextView?.fontSize = CGFloat(value!)
            adjustsWidthToFillItsContens(mainImageView.currentlyEditingLabel)
        }
    }
    
}
//MARK: ShadowTextViewDelegate
extension AddTextViewController:ShadowTextViewDelegate{
    func didTapCloseShadowTextViewButton() {
        self.shadowTextView.removeFromSuperview()
    }
    
    func widthSliderValueChange(value: CGFloat?) {
        widthShadow = value ?? 0.0
        setShadow(widthShadow: self.widthShadow, heightShadow: self.heightShadow, blurShadow: self.blurShadow, colorShadow: self.colorShadow)
        
    }
    
    func heightSliderValueChange(value: CGFloat?) {
        heightShadow = value ?? 0.0
        setShadow(widthShadow: self.widthShadow, heightShadow: self.heightShadow, blurShadow: self.blurShadow, colorShadow: self.colorShadow)
    }
    
    func blurSliderValueChange(value: CGFloat?) {
        blurShadow = value ?? 0.0
        setShadow(widthShadow: self.widthShadow, heightShadow: self.heightShadow, blurShadow: self.blurShadow, colorShadow: self.colorShadow)
    }
    
    func pickShadowColorFinish(color: UIColor?) {
        colorShadow = color ?? UIColor.gray
        setShadow(widthShadow: self.widthShadow, heightShadow: self.heightShadow, blurShadow: self.blurShadow, colorShadow: self.colorShadow)
    }
}
//MARK: FontTextViewDelegate
extension AddTextViewController:FontTextViewDelegate{
    func didTapCloseFontTextView() {
        self.fontTextView.removeFromSuperview()
    }
    
    func didFininshSelectFont(fontName: String) {
        if mainImageView.currentlyEditingLabel != nil{
            mainImageView.currentlyEditingLabel.labelTextView?.fontName = fontName
        }
    }
    
    
}

