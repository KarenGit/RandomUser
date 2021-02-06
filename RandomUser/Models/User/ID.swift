//
//  ID.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

struct ID: Codable {
    let name: String!
    let value: String!
    
    private enum CodingKeys: String, CodingKey {
        case name, value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decode(String.self, forKey: .name)
        self.value = try? container.decode(String.self, forKey: .value)
    }
}
