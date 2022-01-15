//
//  StickerCollectionViewCell.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 14/01/2022.
//

import UIKit

class StickerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stickerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stickerImageView.layer.cornerRadius = 10
        stickerImageView.clipsToBounds = true
    }

}
