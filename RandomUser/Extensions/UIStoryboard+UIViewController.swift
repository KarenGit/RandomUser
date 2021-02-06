//
//  UIStoryboard+UIViewController.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import UIKit

extension UIStoryboard {
    func instantiateViewController<T: NameDescribable>(_ viewControllerType: T.Type) -> T {
        self.instantiateViewController(withIdentifier: viewControllerType.typeName) as! T
    }
}
