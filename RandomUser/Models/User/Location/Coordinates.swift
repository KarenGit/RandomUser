//
//  Coordinates.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

struct Coordinates: Codable {
    let latitude: String!
    let longitude: String!
    
    private enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try? container.decode(String.self, forKey: .latitude)
        self.longitude = try? container.decode(String.self, forKey: .longitude)
    }
}
