//
//  UserTableViewCell.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet private weak var userPictureImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ user: User) {
        self.userPictureImageView.image = Helper.downloadImage(from: user.picture.thumbnail, complition: { (image) in
            self.userPictureImageView.image = image
        })
        
        self.userNameLabel.text = "\(user.name.first ?? String()) \(user.name.last ?? String())"
        self.userInfoLabel.text = """
            \(user.gender ?? String()), \(user.phone ?? String())
            \(user.location.country ?? String())
            \(user.location.street.number ?? 0)  \(user.location.street.name ?? String())
            """
        self.userInfoLabel.sizeToFit()
    }

}
