//
//  UserModel.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/2/3.
//

import Foundation
import RealmSwift

//class UserModelsList: Object, Codable {
//    var userModelsList = List<UserModel>()
//}

class UserModel: Object, Codable {
    @objc dynamic var gender: String?
    @objc dynamic var name: NameModel?
    @objc dynamic var location: LocationModel?
    @objc dynamic var email: String?
    @objc dynamic var login: LoginModel?
    @objc dynamic var dob: DobModel?
    @objc dynamic var registered: DobModel?
    @objc dynamic var phone: String?
    @objc dynamic var cell: String?
    @objc dynamic var id: IDModel?
    @objc dynamic var picture: PictureModel?
    @objc dynamic var nat: String?
}

class NameModel: Object, Codable {
    @objc dynamic var title: String?
    @objc dynamic var first: String?
    @objc dynamic var last: String?
}

class LocationModel: Object, Codable {
    @objc dynamic var street: StreetModel?
    @objc dynamic var city: String?
    @objc dynamic var state: String?
    @objc dynamic var country: String?
    @objc dynamic var postcode: String?
    @objc dynamic var coordinates: CoordinatesModel?
    @objc dynamic var timezone: TimezoneModel?
}
    class StreetModel: Object, Codable {
        @objc dynamic var number: Int = 0
        @objc dynamic var name: String?
    }
    class CoordinatesModel: Object, Codable {
        @objc dynamic var latitude: String?
        @objc dynamic var longitude: String?
    }
    class TimezoneModel: Object, Codable {
        @objc dynamic var offset: String?
        @objc dynamic var descriptionTimezone: String?
    }

class LoginModel: Object, Codable {
    @objc dynamic var uuid: String?
    @objc dynamic var username: String?
    @objc dynamic var password: String?
    @objc dynamic var salt: String?
    @objc dynamic var md5: String?
    @objc dynamic var sha1: String?
    @objc dynamic var sha256: String?
}

class DobModel: Object, Codable {
    @objc dynamic var date: String?
    @objc dynamic var age: Int = 0
}

class IDModel: Object, Codable {
    @objc dynamic var name: String?
    @objc dynamic var value: String?
}

class PictureModel: Object, Codable {
    @objc dynamic var large: String?
    @objc dynamic var medium: String?
    @objc dynamic var thumbnail: String?
}
