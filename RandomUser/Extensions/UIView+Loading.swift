//
//  UIView+Loading.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import UIKit

extension UIView  {
    var isLoading: Bool {
        set {
            (newValue
                ? Loading.showLoading(self, .black, self.backgroundColor)
                : Loading.hideLoading(self))
        }
        get { Loading.isLoading(self) }
    }
}
