//
//  HotelRoomsDTO.swift
//  HotelApp
//
//  Created by admin on 01.09.2023.
//

import Foundation

struct HotelRoomsWrapper: Decodable {
    let rooms: [HotelRoomsDTO]
}

struct HotelRoomsDTO: Decodable {
    let id: Int
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: [String]
    let imageUrl: [String]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case pricePer = "price_per"
        case imageUrl = "image_urls"
        case peculiarities
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        price = try values.decode(Int.self, forKey: .price)
        pricePer = try values.decode(String.self, forKey: .pricePer)
        imageUrl = try values.decode([String].self, forKey: .imageUrl)
        peculiarities = try values.decode([String].self, forKey: .peculiarities)
    }
}
