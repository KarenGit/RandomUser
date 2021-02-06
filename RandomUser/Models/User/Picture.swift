//
//  Picture.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

struct Picture: Codable {
    let large: String!
    let medium: String!
    let thumbnail: String!
    
    private enum CodingKeys: String, CodingKey {
        case large, medium, thumbnail
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.large = try? container.decode(String.self, forKey: .large)
        self.medium = try? container.decode(String.self, forKey: .medium)
        self.thumbnail = try? container.decode(String.self, forKey: .thumbnail)
    }
}
