//
//  User.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

struct User: Codable {
    let gender: String!
    let name: Name!
    let location: Location
    let email: String!
    let login: Login!
    let dob: Dob!
    let registered: Dob!
    let phone: String!
    let cell: String!
    let id: ID!
    let picture: Picture!
    let nat: String!
    
    private enum CodingKeys: String, CodingKey {
        case gender, name, location, email, login, dob, registered, phone, cell, id, picture, nat
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gender = try? container.decode(String.self, forKey: .gender)
        self.name = try? container.decode(Name.self, forKey: .name)
        self.location = try! container.decode(Location.self, forKey: .location)
        self.email = try? container.decode(String.self, forKey: .email)
        self.login = try? container.decode(Login.self, forKey: .login)
        self.dob = try? container.decode(Dob.self, forKey: .dob)
        self.registered = try? container.decode(Dob.self, forKey: .registered)
        self.phone = try? container.decode(String.self, forKey: .phone)
        self.cell = try? container.decode(String.self, forKey: .cell)
        self.id = try? container.decode(ID.self, forKey: .id)
        self.picture = try? container.decode(Picture.self, forKey: .picture)
        self.nat = try? container.decode(String.self, forKey: .nat)
    }
}
