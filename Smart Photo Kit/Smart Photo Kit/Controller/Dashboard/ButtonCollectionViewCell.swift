//
//  ButtonCollectionViewCell.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 27/12/2021.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconButton: UIImageView!
    @IBOutlet weak var nameButton: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(item:MenuButton){
        self.iconButton.image = UIImage(named: item.iconName)
        self.nameButton.text = item.name
    }

}
