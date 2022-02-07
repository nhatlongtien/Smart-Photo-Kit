//
//  CornerCustomeView.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 06/02/2022.
//

import Foundation
import UIKit
@IBDesignable
class CornerCustomeView:UIView{
    @IBInspectable var radius:CGFloat = 10.0
    @IBInspectable var isTopLeft:Bool = false
    @IBInspectable var isTopRight:Bool = false
    @IBInspectable var isBottomLeft:Bool = false
    @IBInspectable var isBottomRight:Bool = false
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        switch (isTopLeft, isTopRight, isBottomLeft, isBottomRight) {
        case (true, false, false, false):
            self.layer.maskedCorners = [.layerMinXMinYCorner]
        case (false, true, false, false):
            self.layer.maskedCorners = [.layerMaxXMinYCorner]
        case (false, false, true, false):
            self.layer.maskedCorners = [.layerMinXMaxYCorner]
        case (false, false, false, true):
            self.layer.maskedCorners = [.layerMaxXMaxYCorner]
        case (true, true, false, false):
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (false, false, true, true):
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case (true, false, true, false):
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case (false, true, false, true):
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case (true, true, true, true):
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        default:
            break
        }
        
    }
}
