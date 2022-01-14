//
//  GradientColorCollectionViewCell.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 31/12/2021.
//

import UIKit

class GradientColorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
    }
    func configCell(item:UIImage){
        imageView.image = item
    }

}
