//
//  FrameModel.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 31/12/2021.
//

import Foundation
import UIKit
class FrameModel{
    var frameViewName:String
    var illustrateImage:UIImage!
    init(frameViewName:String,illustrateImage:UIImage ) {
        self.frameViewName = frameViewName
        self.illustrateImage = illustrateImage
    }
    static func share() -> [FrameModel]{
        return [
            FrameModel(frameViewName: "frame_1", illustrateImage: UIImage(named: "frame_1") ?? UIImage())
            
        ]
    }
}
