//
//  AppSettings.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/2/4.
//

import Foundation
import RealmSwift

class AppSettings {
//    let shared: AppSettings = AppSettings()
    
    var realm: Realm {
        return try! Realm(configuration: Realm.Configuration(objectTypes: [UserModel.self,
                                                                    NameModel.self,
                                                                    LocationModel.self,
                                                                    StreetModel.self,
                                                                    CoordinatesModel.self,
                                                                    TimezoneModel.self,
                                                                    LoginModel.self,
                                                                    DobModel.self,
                                                                    IDModel.self,
                                                                    PictureModel.self]))
    }
}
