//
//  HotelDTO.swift
//  HotelTest
//
//  Created by admin on 30.08.2023.
//

import Foundation

struct HotelDTO: Decodable {
    let id: Int
    let name: String
    let address: String
    let price: Int
    let priceFor: String
    let rating: Int
    let ratingName: String
    let imageUrl: [String]
    let aboutTheHotel: AboutTheHotel
    
    struct AboutTheHotel: Decodable {
        let description: String
        let peculiarities: [String]
        
        private enum CodingKeys: String, CodingKey {
            case description
            case peculiarities
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            description = try values.decode(String.self, forKey: .description)
            peculiarities = try values.decode([String].self, forKey: .peculiarities)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case address = "adress"
        case price = "minimal_price"
        case priceFor = "price_for_it"
        case rating
        case ratingName = "rating_name"
        case imageUrl = "image_urls"
        case aboutTheHotel = "about_the_hotel"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        address = try values.decode(String.self, forKey: .address)
        price = try values.decode(Int.self, forKey: .price)
        priceFor = try values.decode(String.self, forKey: .priceFor)
        rating = try values.decode(Int.self, forKey: .rating)
        ratingName = try values.decode(String.self, forKey: .ratingName)
        imageUrl = try values.decode([String].self, forKey: .imageUrl)
        aboutTheHotel = try values.decode(AboutTheHotel.self, forKey: .aboutTheHotel)
    }
}
