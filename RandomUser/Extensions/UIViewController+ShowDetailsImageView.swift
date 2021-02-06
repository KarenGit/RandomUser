//
//  UIViewController+ShowDetailsImageView.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/2/1.
//

import UIKit

extension UIViewController {
    
    func showFullScreenImageIfNeeded(_ imageURL: String?) {
        guard imageURL != nil,
              imageURL! != " ",
              !imageURL!.isEmpty else { return }
        
        let fullScreenImageView = FullScreenImageView(frame: UIScreen.main.bounds)
        fullScreenImageView.setImage(imageURL)
        fullScreenImageView.didDismiss = { [weak self] in
            self?.view.transit({
                fullScreenImageView.removeFromSuperview()
            })
        }
        
        self.view.transit({ [weak self] in
            self?.view.addSubview(fullScreenImageView)
        })
    }
}
