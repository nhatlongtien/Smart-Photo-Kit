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
            FrameModel(frameViewName: "frame_1", illustrateImage: UIImage(named: "frame_1") ?? UIImage()),
            FrameModel(frameViewName: "frame_2", illustrateImage: UIImage(named: "frame_2") ?? UIImage()),
            FrameModel(frameViewName: "frame_3", illustrateImage: UIImage(named: "frame_3") ?? UIImage()),
            FrameModel(frameViewName: "frame_4", illustrateImage: UIImage(named: "frame_4") ?? UIImage()),
            FrameModel(frameViewName: "frame_5", illustrateImage: UIImage(named: "frame_5") ?? UIImage()),
            FrameModel(frameViewName: "frame_6", illustrateImage: UIImage(named: "frame_6") ?? UIImage()),
            FrameModel(frameViewName: "frame_7", illustrateImage: UIImage(named: "frame_7") ?? UIImage()),
            FrameModel(frameViewName: "frame_8", illustrateImage: UIImage(named: "frame_8") ?? UIImage()),
            FrameModel(frameViewName: "frame_9", illustrateImage: UIImage(named: "frame_9") ?? UIImage()),
        ]
    }
}
