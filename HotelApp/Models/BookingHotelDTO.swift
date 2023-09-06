//
//  BookingHotelDTO.swift
//  HotelApp
//
//  Created by admin on 02.09.2023.
//

import Foundation

struct BookingHotelDTO: Decodable {
    let id: Int
    let hotelName: String
    let hotelAddress: String
    let horating: Int
    let ratingName: String
    let departure: String
    let arrivalCountry: String
    let tourStart: String
    let tourStop: String
    let numberOfNights: Int
    let room: String
    let nutrition: String
    let price: Int
    let fuelCharge: Int
    let serviceCharge: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case hotelName = "hotel_name"
        case hotelAddress = "hotel_adress"
        case horating
        case ratingName = "rating_name"
        case departure
        case arrivalCountry = "arrival_country"
        case tourStart = "tour_date_start"
        case tourStop = "tour_date_stop"
        case numberOfNights = "number_of_nights"
        case room
        case nutrition
        case price = "tour_price"
        case fuelCharge = "fuel_charge"
        case serviceCharge = "service_charge"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.hotelName = try container.decode(String.self, forKey: .hotelName)
        self.hotelAddress = try container.decode(String.self, forKey: .hotelAddress)
        self.horating = try container.decode(Int.self, forKey: .horating)
        self.ratingName = try container.decode(String.self, forKey: .ratingName)
        self.departure = try container.decode(String.self, forKey: .departure)
        self.arrivalCountry = try container.decode(String.self, forKey: .arrivalCountry)
        self.tourStart = try container.decode(String.self, forKey: .tourStart)
        self.tourStop = try container.decode(String.self, forKey: .tourStop)
        self.numberOfNights = try container.decode(Int.self, forKey: .numberOfNights)
        self.room = try container.decode(String.self, forKey: .room)
        self.nutrition = try container.decode(String.self, forKey: .nutrition)
        self.price = try container.decode(Int.self, forKey: .price)
        self.fuelCharge = try container.decode(Int.self, forKey: .fuelCharge)
        self.serviceCharge = try container.decode(Int.self, forKey: .serviceCharge)
    }
}
