//
//  MenuButtonAddTextCollectionViewCell.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 28/12/2021.
//

import UIKit

class MenuButtonAddTextCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleButton: UILabel!
    @IBOutlet weak var iconButton: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(item:AddTextmenuButton){
        self.titleButton.text = item.title
        self.iconButton.image = UIImage(named: item.icon)
    }
}
