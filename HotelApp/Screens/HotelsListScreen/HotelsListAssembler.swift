//
//  HotelsListAssembler.swift
//  HotelApp
//
//  Created by admin on 31.08.2023.
//

import Foundation

enum HotelsListAssembler {
    static func assemble(name: String) -> HotelsListVC {
        let apiServices = ApiServices()
        let hotelListVC = HotelsListVC()
        let hotelListVM = HotelsListVM()
        
        hotelListVM.view = hotelListVC
        hotelListVM.apiService = apiServices
        hotelListVC.vm = hotelListVM
        hotelListVC.name = name
        
        return hotelListVC
    }
}
