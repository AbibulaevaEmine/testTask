//
//  BookingAssembler.swift
//  HotelApp
//
//  Created by admin on 02.09.2023.
//

import Foundation

struct BookingAssembler {
    static func assemble() -> BookingVC {
        let apiServices = ApiServices()
        let bookingVC = BookingVC()
        let bookingVM = BookingVM()
        
        bookingVM.view = bookingVC
        bookingVC.vm = bookingVM
        bookingVM.apiServices = apiServices
        
        return bookingVC
    }
}
