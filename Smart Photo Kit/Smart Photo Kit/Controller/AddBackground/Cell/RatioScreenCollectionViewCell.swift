//
//  RatioScreenCollectionViewCell.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 04/01/2022.
//

import UIKit

class RatioScreenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(item:String){
        titleLbl.text = item
    }

}
