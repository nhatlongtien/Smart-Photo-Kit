//
//  ScaleUIImageView.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 02/01/2022.
//

import Foundation
import UIKit
class ScaledHeightImageView: UIImageView {

//    override var intrinsicContentSize: CGSize {
//
//        if let myImage = self.image {
//            let myImageWidth = myImage.size.width
//            let myImageHeight = myImage.size.height
//            let myViewWidth = self.frame.size.width
//            let myViewHeight = self.frame.size.height
//            let ratio = myViewWidth/myImageWidth
//            if self.frame.width > self.frame.height{
//                let scaledHeight = myImageHeight * ratio
//
//                return CGSize(width: myViewWidth, height: scaledHeight)
//            }else{
//                let scaledWidth = myImageWidth * ratio
//                return CGSize(width: scaledWidth, height: myViewHeight)
//            }
//
//        }
//
//        return CGSize(width: -1.0, height: -1.0)
//    }
    
    override var intrinsicContentSize: CGSize
        {
            // VALIDATE ELSE RETURN
            // frameSizeWidth
            let frameSizeWidth = self.frame.size.width

            // image
            // ⓘ In testing on iOS 12.1.4 heights of 1.0 and 0.5 were respected, but 0.1 and 0.0 led intrinsicContentSize to be ignored.
            guard let image = self.image else
            {
                return CGSize(width: frameSizeWidth, height: 1.0)
            }

            // MAIN
            let returnHeight = ceil(image.size.height * (frameSizeWidth / image.size.width))
            return CGSize(width: frameSizeWidth, height: returnHeight)
        }

}
