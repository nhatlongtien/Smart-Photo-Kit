//
//  CustomeUIImageView.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 01/01/2022.
//

import Foundation
import UIKit
@IBDesignable
class CustomeUIImageView:UIImageView{
    @IBInspectable var rotate:CGFloat = 0.0
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        let radians = rotate / 180.0 * CGFloat.pi
        self.transform = self.transform.rotated(by: radians)
        self.clipsToBounds = true
    }
}
