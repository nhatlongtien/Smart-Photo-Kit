//
//  TextColorCollectionViewCell.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 29/12/2021.
//

import UIKit

class TextColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorView: CustomeBoderRadiusView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configCell(item:UIColor){
        self.colorView.backgroundColor = item
    }

}
