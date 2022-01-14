//
//  StickerModel.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 14/01/2022.
//

import Foundation
import SwiftyJSON
class StickerModel{
    var groupName:String?
    var listItem:[String]
    
    init (listItem:[JSON], groupName:String?){
        self.groupName = groupName
        var list:[String] = []
        for item in listItem{
            let itemString = item.stringValue
            list.append(itemString)
        }
        self.listItem = list ?? []
    }
}
