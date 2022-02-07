//
//  BottomCollectionViewCell.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 24/01/2022.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var stickerImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(item:StickerMenu){
        titleLbl.text = item.title
        stickerImgView.image = item.image
    }

}
