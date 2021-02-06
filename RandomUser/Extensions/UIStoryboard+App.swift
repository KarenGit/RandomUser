//
//  UIStoryboard+App.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import UIKit

extension UIStoryboard {
    enum App: String {
        case saveAndRemoveUser
        
        var storyboard: UIStoryboard {
            UIStoryboard(name: self.rawValue.capitalizedFirstLetter, bundle: nil)
        }
    }
}
