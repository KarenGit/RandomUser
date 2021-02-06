//
//  Loading.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import UIKit

open class Loading {
  private static var loadingView = UIView()
  private static var container = UIView()
    private static var activityIndicator = UIActivityIndicatorView(style: .medium)
  
  class func showLoading(_ view: UIView,
                         _ indicatorColor: UIColor?,
                         _ backgroundColor: UIColor?,
                         _ activityIndicatorTransform: CGAffineTransform = CGAffineTransform(scaleX: 1, y: 1)) {
    guard !Self.isLoading(view) else { return }
    
    Self.hideLoading(nil)
    
    view.layoutIfNeeded()
    activityIndicator.transform = activityIndicatorTransform
    loadingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height))
    loadingView.backgroundColor = backgroundColor
    loadingView.clipsToBounds = true
    loadingView.isUserInteractionEnabled = false
    view.addSubview(loadingView)
    view.bringSubviewToFront(loadingView)
    //loadingView.center = view.center
    
    container = UIView(frame: CGRect(x: 0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height))
    container.clipsToBounds = true
    loadingView.addSubview(container)
    loadingView.bringSubviewToFront(container)
    container.center = loadingView.center
    
    activityIndicator.color = indicatorColor
    container.addSubview(activityIndicator)
    
    activityIndicator.center = container.center
    activityIndicator.startAnimating()
    view.setNeedsLayout()
    view.layoutIfNeeded()
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    view.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
  }
  
  class func hideLoading(_ view: UIView?) {
    activityIndicator.stopAnimating()
    activityIndicator.removeFromSuperview()
    container.removeFromSuperview()
    loadingView.removeFromSuperview()
    view?.setNeedsLayout()
    view?.layoutIfNeeded()
  }
  
  class func isLoading(_ view: UIView) -> Bool {
    (self.loadingView.superview === view)
  }
}
