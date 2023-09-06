//
//  ApiServices+Endpoints.swift
//  HotelApp
//
//  Created by admin on 30.08.2023.
//

import Foundation
import RxSwift

protocol PApiServices {
    func getDataForHotel() -> Single<HotelDTO>
}

extension ApiServices: PApiServices {
    func getDataForHotel() -> Single<HotelDTO> {
        fetchData(url: .hotelURL).asSingle()
    }
    
    func getDataForHotelRooms() -> Single<HotelRoomsWrapper> {
        fetchData(url: .hotelsListURL).asSingle()
    }
    
    func getDataForBooking() -> Single<BookingHotelDTO> {
        fetchData(url: .bookingHotelURL).asSingle()
    }
}
