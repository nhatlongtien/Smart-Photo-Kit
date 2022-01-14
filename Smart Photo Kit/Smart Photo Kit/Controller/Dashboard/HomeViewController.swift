//
//  HomeViewController.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 27/12/2021.
//

import UIKit
import Brightroom
import FMPhotoPicker
import TCMask
class HomeViewController: BaseViewController {
    @IBOutlet weak var workPlaceView: UIView!
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var heightImgConstant: NSLayoutConstraint!
    @IBOutlet weak var widthImgConstant: NSLayoutConstraint!
    @IBOutlet weak var containerImageView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var heightEmptyView: NSLayoutConstraint!
    //
    let menuButton = MenuButton.share()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .horizontal
        menuCollectionView.collectionViewLayout = layout
        let nibCell = UINib(nibName: "ButtonCollectionViewCell", bundle: nil)
        menuCollectionView.register(nibCell, forCellWithReuseIdentifier: "ButtonCollectionViewCell")
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        //
        //fitAspectFitImageView()
        imageView.isHidden = true
        emptyView.isHidden = false
    }
    //MARK: UIEvent
    @IBAction func cameraButtonWasPressed(_ sender: Any) {
        accessCamera()
    }
    
    @IBAction func photoButtonWasPressed(_ sender: Any) {
        var config = FMPhotoPickerConfig()
        config.selectMode = .single
        let picker = FMPhotoPickerViewController(config: config)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @IBAction func deleteButtonWasPressed(_ sender: Any) {
        if imageView.image != nil{
            let alert = UIAlertController(title: "Opps!", message: "Do you want to delete", preferredStyle: .alert)
            let btnCancle = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let btnOK = UIAlertAction(title: "OK", style: .default) { action in
                self.imageView.image = nil
                self.imageView.isHidden = true
                self.emptyView.isHidden = false
            }
            alert.addAction(btnCancle)
            alert.addAction(btnOK)
            self.present(alert, animated: true, completion: nil)
        }else{
            showAlert("Opps!", message: "No image to delete")
        }
    }
    @IBAction func shareButtonWasPressed(_ sender: Any) {
    }
    @IBAction func saveButtonWasPressed(_ sender: Any) {
        if let image = imageView.image{
            saveImageToAllbum(with: image)
        }else{
            showAlert("Opps!", message: "No image to save!")
        }
        
    }
    //MARK: Helper Method
    private func fitAspectFitImageView(){
        if imageView.contentClippingRect.height ==  imageView.contentClippingRect.width{ //Square condition
            if containerImageView.frame.size.width <= containerImageView.frame.size.height{
                heightImgConstant.constant = containerImageView.frame.size.width
                widthImgConstant.constant = containerImageView.frame.size.width
            }else{
                heightImgConstant.constant = containerImageView.frame.size.height
                widthImgConstant.constant = containerImageView.frame.size.height
            }
        }else{ //width of image is grater than width of contaner image
            if imageView.contentClippingRect.width > containerImageView.frame.size.width{
                let ratio = imageView.contentClippingRect.width / containerImageView.frame.size.width
                heightImgConstant.constant = imageView.contentClippingRect.height / ratio
                widthImgConstant.constant = imageView.contentClippingRect.width / ratio
            }else{
                heightImgConstant.constant = imageView.contentClippingRect.height
                widthImgConstant.constant = imageView.contentClippingRect.width
            }
        }
    }
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
}
//MARK: Pick photo from camera
extension HomeViewController{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageView.image = image
        fitAspectFitImageView()
        self.imageView.isHidden = false
        self.emptyView.isHidden = true
    }
}
//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuButton.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
        cell.configCell(item: menuButton[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 55)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let uiImage: UIImage = imageView.image!
            let controller = PhotosCropViewController(imageProvider: .init(image: uiImage))
            controller.modalPresentationStyle = .fullScreen
            //
            controller.handlers.didCancel = { controller in
                controller.dismiss(animated: true, completion: nil)
            }
            //
            controller.handlers.didFinish = { [weak self] controller in
                controller.dismiss(animated: true, completion: nil)
                try! controller.editingStack.makeRenderer().render { [weak self] image in
                    switch image {
                    case .success(let rendered):
                        self?.imageView.image = rendered.uiImage
                    case .failure(let err):
                        print(err)
                    default:
                        break
                    }
                }
            }
            self.present(controller, animated: true, completion: nil)
        case 1:
            var options = ClassicImageEditOptions()
            options.croppingAspectRatio = nil
            let uiImage: UIImage = imageView.image!
            let controller = ClassicImageEditViewController(imageProvider: .init(image: uiImage), options: options)
            
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .fullScreen
            controller.handlers.didCancelEditing = { controller in
                controller.dismiss(animated: true, completion: nil)
            }
            controller.handlers.didEndEditing = { [weak self] controller, stack in
                guard let self = self else { return }
                controller.dismiss(animated: true, completion: nil)
                
                try! stack.makeRenderer().render { result in
                    switch result {
                    case let .success(rendered):
                        self.imageView.image = rendered.uiImage
                    case let .failure(error):
                        print(error)
                    }
                }
            }
            
            self.present(navigationController, animated: true, completion: nil)
        case 2:
            var config = FMPhotoPickerConfig()
            let uiImage: UIImage = imageView.image!
            let editor = FMImageEditorViewController(config: config, sourceImage: uiImage)
            editor.delegate = self
            self.present(editor, animated: true)
        case 3:
            let uiImage: UIImage = imageView.image!
            let maskView = TCMaskView(image: uiImage)
            maskView.delegate = self
            maskView.presentFrom(rootViewController: self, animated: true)
        case 4:
            let addTextVC = AddTextViewController()
            addTextVC.delegate = self
            addTextVC.selectedImg = imageView.image
            addTextVC.modalPresentationStyle = .fullScreen
            self.present(addTextVC, animated: true, completion: nil)
        case 5:
            let targetVC = AddBackgroundViewController()
            targetVC.delegate = self
            targetVC.modalPresentationStyle = .fullScreen
            targetVC.image = imageView.image
            self.present(targetVC, animated: true, completion: nil)
        case 6:
            let targetVC = CreateGalleryCollectionViewController()
            targetVC.modalPresentationStyle = .fullScreen
            self.present(targetVC, animated: true, completion: nil)
        case 7:
            //Remove background image
            if let image = imageView.image{
                let resultImage = image.removeBackground(returnResult: .finalImage)
                imageView.image = resultImage
            }
        default:
            break
        }
    }
}
//MARK: FMImageEditorViewControllerDelegate, FMPhotoPickerViewControllerDelegate
extension HomeViewController: FMImageEditorViewControllerDelegate, FMPhotoPickerViewControllerDelegate{
    func fmImageEditorViewController(_ editor: FMImageEditorViewController, didFinishEdittingPhotoWith photo: UIImage) {
        self.dismiss(animated: true, completion: nil)
        self.imageView.image = photo
    }
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]){
        self.dismiss(animated: true, completion: nil)
        
        heightImgConstant.constant = containerImageView.frame.size.height
        widthImgConstant.constant = containerImageView.frame.size.width
        view.layoutIfNeeded()
        self.imageView.image = photos.first
        fitAspectFitImageView()
        self.imageView.isHidden = false
        self.emptyView.isHidden = true
        print(photos)
    }
    
}
//MARK: TCMaskViewDelegate
extension HomeViewController:TCMaskViewDelegate{
    func tcMaskViewDidComplete(mask: TCMask, image: UIImage) {
        let outputImage = mask.cutout(image: image, resize: false)
        heightImgConstant.constant = containerImageView.frame.size.height
        widthImgConstant.constant = containerImageView.frame.size.width
        
        self.imageView.image = outputImage
        view.layoutIfNeeded()
        fitAspectFitImageView()
    }
}
extension HomeViewController:AddTextViewControllerDelegate{
    func didFinishAddTextInImage(image: UIImage?) {
        heightImgConstant.constant = containerImageView.frame.size.height
        widthImgConstant.constant = containerImageView.frame.size.width
        
        self.imageView.image = image
        view.layoutIfNeeded()
        fitAspectFitImageView()
        
    }
}
extension HomeViewController:AddBackgroundViewControllerDelegate{
    func didFinshDesign(image: UIImage?) {
        print(containerImageView.frame.size.height)
        print(containerImageView.frame.size.width)
        heightImgConstant.constant = containerImageView.frame.size.height
        widthImgConstant.constant = containerImageView.frame.size.width
        
        self.imageView.image = image
        self.view.layoutIfNeeded()
        print(self.imageView.contentClippingRect)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            self.fitAspectFitImageView()
            
        }
        
        
    }
    
    
}
