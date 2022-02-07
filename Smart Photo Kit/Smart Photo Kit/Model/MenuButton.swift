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
            MenuButton(name: "Smart Kit", iconName: "remove_bg_icon"),
            MenuButton(name: "Crop", iconName: "crop"),
            MenuButton(name: "Edit", iconName: "edit"),
            MenuButton(name: "Filter", iconName: "icon_filter_white"),
            MenuButton(name: "Add Text", iconName: "add_text_icon"),
            MenuButton(name: "Photo Creator", iconName: "photo_creator"),
            MenuButton(name: "Frame", iconName: "collage"),
            //MenuButton(name: "Remove", iconName: "frame_icon"),
        ]
    }
}
