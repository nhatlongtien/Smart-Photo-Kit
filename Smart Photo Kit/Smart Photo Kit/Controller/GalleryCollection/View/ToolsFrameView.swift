//
//  ToolsFrameView.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 01/01/2022.
//

import UIKit
protocol ToolsFrameViewDelegate:class{
    func didFinishPickerColor(color:UIColor)
    func didFinishPickerGradientColor(gradientColor:UIImage)
    func didSelectMoreSticker(sticker:[StickerModel]?)
    func didSelecteGeneralSticker(sticker:UIImage?)
}
class ToolsFrameView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var gradientCollectionView: UICollectionView!
    @IBOutlet weak var stickerCollectionView: UICollectionView!
    //
    let colors = Array(ColorModel.shareColor().reversed())
    let gradientColorImgs = GradientColorModel.share()
    weak var delegate:ToolsFrameViewDelegate?
    let stickerVM = StickerViewModel()
    var sticker:[StickerModel] = []
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    func setupView(){
        Bundle.main.loadNibNamed("ToolsFrameView", owner: self, options: nil)
        self.addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
        //TODO: Config stickerCollectionView
        let frameLayout = UICollectionViewFlowLayout()
        frameLayout.scrollDirection = .horizontal
        frameLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stickerCollectionView.collectionViewLayout = frameLayout
        let frameNibCell = UINib(nibName: "GradientColorCollectionViewCell", bundle: nil)
        stickerCollectionView.register(frameNibCell, forCellWithReuseIdentifier: "GradientColorCollectionViewCell")
        stickerCollectionView.delegate = self
        stickerCollectionView.dataSource = self
        //
        stickerVM.getSticker { success, sticker in
            if success{
                self.sticker = sticker ?? []
                self.stickerCollectionView.reloadData()
            }
        }
    }
}
extension ToolsFrameView:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
        }else{
            return CGSize()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colorCollectionView{
            print("colorCollectionView")
            self.delegate?.didFinishPickerColor(color: colors[indexPath.row])
        }else if collectionView == gradientCollectionView{
            print("gradientCollectionView")
            self.delegate?.didFinishPickerGradientColor(gradientColor: gradientColorImgs[indexPath.row])
        }else if collectionView == stickerCollectionView{
            if indexPath.row == 10{
                print("More sticker image")
                self.delegate?.didSelectMoreSticker(sticker: self.sticker)
            }else{
                let cell = collectionView.cellForItem(at: indexPath) as! GradientColorCollectionViewCell
                let stickerImg = cell.imageView.image
                self.delegate?.didSelecteGeneralSticker(sticker: stickerImg)
            }
        }
    }
}
