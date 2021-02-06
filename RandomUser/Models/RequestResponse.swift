//
//  RequestResponse.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

struct RequestResponse: Codable {
    let results: [User]!
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try? container.decode([User].self, forKey: .results)
    }
}
