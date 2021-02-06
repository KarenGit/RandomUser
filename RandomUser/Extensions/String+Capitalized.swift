//
//  String+Capitalized.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import Foundation

extension String {
  var capitalizedFirstLetter: String {
        let capitalizedFirstLetter = (self.prefix(1).capitalized + self.dropFirst())
        return capitalizedFirstLetter
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizedFirstLetter
    }
}
