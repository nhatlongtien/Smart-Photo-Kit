//
//  StickerViewController.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 14/01/2022.
//

import UIKit
import SnapKit
import PullToDismiss
protocol StickerViewControllerDelegate:class{
    func passStickerImage(sticker:UIImage?)
}
class StickerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var slideDown: CornerCustomeView!
    @IBOutlet weak var stickerCollectionView: UICollectionView!
    //private var pullToDismiss: PullToDismiss?
    //
    var sticker:[StickerModel] = []
    var listSticker:[String] = []
    var stickerMenu = StickerMenu.share()
    weak var delegate:StickerViewControllerDelegate?
    //
    override func viewDidLoad() {
        super.viewDidLoad()
//        pullToDismiss = PullToDismiss(scrollView: stickerCollectionView)
//        pullToDismiss?.delegate = self
        //
        containerViewHeight.constant = self.view.frame.height / 2
        slideDown.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:))))
        
        listSticker = sticker.first!.listItem
        
        let bottomLayer = UICollectionViewFlowLayout()
        bottomLayer.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        bottomLayer.scrollDirection = .horizontal
        bottomCollectionView.collectionViewLayout = bottomLayer
        let bottomCell = UINib(nibName: "BottomCollectionViewCell", bundle: nil)
        bottomCollectionView.register(bottomCell, forCellWithReuseIdentifier: "BottomCollectionViewCell")
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        //
        let stickerLayout = UICollectionViewFlowLayout()
        stickerLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
        stickerLayout.scrollDirection = .vertical
        stickerCollectionView.collectionViewLayout = stickerLayout
        let stickerCell = UINib(nibName: "StickerCollectionViewCell", bundle: nil)
        stickerCollectionView.register(stickerCell, forCellWithReuseIdentifier: "StickerCollectionViewCell")
        stickerCollectionView.delegate = self
        stickerCollectionView.dataSource = self
        //
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelDidTapContainerView)))
    }
    @objc func handelDidTapContainerView(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer){
        let translation = panGesture.translation(in: self.view)
        let location = panGesture.location(in: self.view)
        print(location)
        if panGesture.state == .changed{
            containerViewHeight.constant = self.view.frame.height - location.y
        }else if panGesture.state == .ended{
            if location.y < (self.view.frame.height/3){
                containerViewHeight.constant = self.view.frame.height - 100
            }else if location.y > (self.view.frame.height/1.5){
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}


extension StickerViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bottomCollectionView{
            return stickerMenu.count
        }else{
            return listSticker.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bottomCollectionView{
            let cell = bottomCollectionView.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCell", for: indexPath) as! BottomCollectionViewCell
            cell.configCell(item: stickerMenu[indexPath.row])
            return cell
        }else{
            let cell = stickerCollectionView.dequeueReusableCell(withReuseIdentifier: "StickerCollectionViewCell", for: indexPath) as! StickerCollectionViewCell
            let imgUrl = URL(string: listSticker[indexPath.row])
            cell.stickerImageView.kf.setImage(with: imgUrl)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bottomCollectionView{
            listSticker = sticker[indexPath.row].listItem
            stickerCollectionView.reloadData()
        }else if collectionView == stickerCollectionView{
            let cell = stickerCollectionView.cellForItem(at: indexPath) as! StickerCollectionViewCell
            delegate?.passStickerImage(sticker: cell.stickerImageView.image)
            self.dismiss(animated: true, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bottomCollectionView{
            return CGSize(width: 90, height: 70)
        }else{
            let numberOfColum:CGFloat = 4
            let widthCell:CGFloat = (stickerCollectionView.frame.width - 10*(numberOfColum - 1) - 30) / numberOfColum
            return CGSize(width: widthCell, height: widthCell)
        }
    }
}

