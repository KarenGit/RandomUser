//
//  UIColor+App.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/2/5.
//

import UIKit

extension UIColor {
    enum App: String {
        case gray232
        case greenButton
        
        var color: UIColor? {
            return UIColor(named: self.rawValue)
        }
    }
}
