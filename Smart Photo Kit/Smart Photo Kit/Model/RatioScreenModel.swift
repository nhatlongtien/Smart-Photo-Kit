//
//  RatioScreenModel.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 04/01/2022.
//

import Foundation
class RatioScreenModel{
    static func shareRatioHorizontalScreen() -> [String]{
        return ["SQUARE", "9:16", "8:10", "5:7", "3:4", "3:5", "2:3"]
    }
    static func shareRatioVerticalScreen() -> [String]{
        return ["SQUARE", "16:9", "10:8", "7:5", "4:3", "5:3", "3:2"]
    }
}
