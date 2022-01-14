//
//  MenuButton.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 28/12/2021.
//

import Foundation
class MenuButton{
    var name: String
    var iconName:String
    
    init(name:String, iconName:String) {
        self.name = name
        self.iconName = iconName
    }
    static func share() -> [MenuButton]{
        return [
            MenuButton(name: "Crop", iconName: "icon_crop_white"),
            MenuButton(name: "Edit", iconName: "icon_edited_white"),
            MenuButton(name: "Filter", iconName: "icon_filter_white"),
            MenuButton(name: "Remove Bg", iconName: "remove_bg_icon"),
            MenuButton(name: "Add Text", iconName: "add_text_icon"),
            MenuButton(name: "Photo Creator", iconName: "designer_icon"),
            MenuButton(name: "Frame", iconName: "frame_icon"),
            MenuButton(name: "Remove", iconName: "frame_icon"),
        ]
    }
}
