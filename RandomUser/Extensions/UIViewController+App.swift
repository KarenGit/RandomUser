//
//  UIViewController+App.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import UIKit

extension UIViewController {
    enum App: String {
        case saveAndRemoveUser
        
        var viewController: UIViewController {
            switch self {
            case .saveAndRemoveUser:
                return UIStoryboard.App.saveAndRemoveUser.storyboard.instantiateViewController(SaveAndRemoveUserViewController.self)
            }
        }
        
        func asViewController<T: UIViewController>(_ type: T.Type) -> T {
            (self.viewController as! T)
        }
    }
}
