//
//  Name.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

struct Name: Codable {
    let title: String!
    let first: String!
    let last: String!
    
    private enum CodingKeys: String, CodingKey {
        case title, first, last
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try? container.decode(String.self, forKey: .title)
        self.first = try? container.decode(String.self, forKey: .first)
        self.last = try? container.decode(String.self, forKey: .last)
    }
}
