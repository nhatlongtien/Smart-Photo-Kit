//
//  UIView+Extension.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 02/01/2022.
//

import Foundation
import UIKit
extension UIView{
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        return image
    }
}
