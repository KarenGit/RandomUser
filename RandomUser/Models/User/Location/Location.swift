//
//  Location.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

struct Location: Codable {
    let street: Street!
    let city: String!
    let state: String!
    let country: String!
    let postcode: String!
    let coordinates: Coordinates!
    let timezone: Timezone!

    private enum CodingKeys: String, CodingKey {
        case street, city, state, country, postcode, coordinates, timezone
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try? container.decode(Street.self, forKey: .street)
        self.city = try? container.decode(String.self, forKey: .city)
        self.state = try? container.decode(String.self, forKey: .state)
        self.country = try? container.decode(String.self, forKey: .country)
        self.postcode = try? container.decode(String.self, forKey: .postcode)
        self.coordinates = try? container.decode(Coordinates.self, forKey: .coordinates)
        self.timezone = try? container.decode(Timezone.self, forKey: .timezone)
    }
}
