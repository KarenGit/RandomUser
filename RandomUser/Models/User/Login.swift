//
//  Login.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

struct Login: Codable {
    let uuid: String!
    let username: String!
    let password: String!
    let salt: String!
    let md5: String!
    let sha1: String!
    let sha256: String!
    
    private enum CodingKeys: String, CodingKey {
        case uuid, username, password, salt, md5, sha1, sha256
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try? container.decode(String.self, forKey: .uuid)
        self.username = try? container.decode(String.self, forKey: .username)
        self.password = try? container.decode(String.self, forKey: .password)
        self.salt = try? container.decode(String.self, forKey: .salt)
        self.md5 = try? container.decode(String.self, forKey: .md5)
        self.sha1 = try? container.decode(String.self, forKey: .sha1)
        self.sha256 = try? container.decode(String.self, forKey: .sha256)
    }
}
