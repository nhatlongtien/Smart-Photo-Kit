//
//  FontCollectionViewCell.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 11/01/2022.
//

import UIKit

class FontCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(item:String){
        titleLbl.font = UIFont(name: item, size: 20)
    }

}
