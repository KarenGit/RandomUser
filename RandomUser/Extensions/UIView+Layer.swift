//
//  UIView+Layer.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        set { self.layer.cornerRadius = newValue }
        get { self.layer.cornerRadius }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        set { self.layer.borderWidth = newValue }
        get {  self.layer.borderWidth }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        set { self.layer.borderColor = newValue?.cgColor }
        get { (self.layer.borderColor == nil ? nil : UIColor(cgColor: self.layer.borderColor!)) }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        set { self.layer.shadowRadius = newValue }
        get { self.layer.shadowRadius }
    }
    
    @IBInspectable
    var shadowOpacity: CGFloat {
        set { self.layer.shadowOpacity = Float(newValue) }
        get { CGFloat(self.layer.shadowOpacity) }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        set { self.layer.shadowOffset = newValue }
        get { self.layer.shadowOffset }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        set { self.layer.shadowColor = newValue?.cgColor }
        get { (self.layer.shadowColor == nil ? nil : UIColor(cgColor: self.layer.shadowColor!)) }
    }
}
