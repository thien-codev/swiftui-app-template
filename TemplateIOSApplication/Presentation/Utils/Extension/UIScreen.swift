//
//  UIScreen.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 04/11/2023.
//

import Foundation
import UIKit

extension UIScreen {
    static var height: CGFloat {
        return main.bounds.height
    }
    
    static var width: CGFloat {
        return main.bounds.width
    }
}
