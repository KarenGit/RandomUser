//
//  Timezone.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

struct Timezone: Codable {
    let offset: String!
    let description: String!
    
    private enum CodingKeys: String, CodingKey {
        case offset, description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.offset = try? container.decode(String.self, forKey: .offset)
        self.description = try? container.decode(String.self, forKey: .description)
    }
}
