//
//  StickerTableViewCell.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 14/01/2022.
//

import UIKit
protocol StickerTableViewCellDelegate:class{
    func didFinishSelectStickerImg(sticker:UIImage?)
}
class StickerTableViewCell: UITableViewCell {

    @IBOutlet weak var stickerCollectionView: UICollectionView!
    var stickerImgs = [String]()
    weak var delegate:StickerTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stickerCollectionView.collectionViewLayout = layout
        let nibCell = UINib(nibName: "StickerCollectionViewCell", bundle: nil)
        stickerCollectionView.register(nibCell, forCellWithReuseIdentifier: "StickerCollectionViewCell")
        stickerCollectionView.dataSource = self
        stickerCollectionView.delegate = self
    }
    func configCell(listSticker:[String]){
        self.stickerImgs = listSticker
        self.stickerCollectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension StickerTableViewCell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickerImgs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = stickerCollectionView.dequeueReusableCell(withReuseIdentifier: "StickerCollectionViewCell", for: indexPath) as! StickerCollectionViewCell
        let imageUrl = URL(string: stickerImgs[indexPath.row])
        cell.stickerImageView.kf.setImage(with: imageUrl)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! StickerCollectionViewCell
        let image = cell.stickerImageView.image
        delegate?.didFinishSelectStickerImg(sticker: image)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
