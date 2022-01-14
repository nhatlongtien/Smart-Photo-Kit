//
//  CustomSlider.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 30/12/2021.
//

import Foundation
import UIKit
@IBDesignable
class CustomSlider:UISlider{
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.thumbTintColor = .black
        self.minimumTrackTintColor = .gray
        self.maximumTrackTintColor = .gray
        
    }
}
