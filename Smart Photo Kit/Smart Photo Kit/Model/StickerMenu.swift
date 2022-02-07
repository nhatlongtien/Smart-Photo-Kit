//
//  StickerMenu.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 24/01/2022.
//

import Foundation
import UIKit
class StickerMenu{
    var image: UIImage?
    var title:String
    
    init(image:UIImage?, title:String) {
        self.image = image
        self.title = title
    }
    
    static func share() -> [StickerMenu]{
        return [
            StickerMenu(image: UIImage(named: "emoji_icon"), title: "Emoji"),
            StickerMenu(image: UIImage(named: "price_tag_icon"), title: "Price Tag"),
            StickerMenu(image: UIImage(named: "label_icon"), title: "Label"),
            StickerMenu(image: UIImage(named: "holiday_icon"), title: "Holiday"),
            StickerMenu(image: UIImage(named: "nature_icon"), title: "Nature"),
        ]
    }
}
