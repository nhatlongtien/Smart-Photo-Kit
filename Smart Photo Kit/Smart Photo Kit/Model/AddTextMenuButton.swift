//
//  AddTextMenuButton.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 28/12/2021.
//

import Foundation
class AddTextmenuButton{
    var title:String
    var icon:String
    
    init(title:String, icon:String) {
        self.title = title
        self.icon = icon
    }
    
    static func share() -> [AddTextmenuButton]{
        return [
            AddTextmenuButton(title: "Add Text", icon: "add_text_box_icon"),
            AddTextmenuButton(title: "Style", icon: "font_style_icon"),
            AddTextmenuButton(title: "Size", icon: "font_size_icon"),
            AddTextmenuButton(title: "Color", icon: "font_color_icon"),
            AddTextmenuButton(title: "Shadow", icon: "font_shadow_icon"),
            AddTextmenuButton(title: "Alignment", icon: "text_alignment_icon"),
            //AddTextmenuButton(title: "Spacing", icon: "text_spacing_icon"),
        ]
    }
}
