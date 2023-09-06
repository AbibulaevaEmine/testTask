//
//  HotelAssembler.swift
//  HotelApp
//
//  Created by admin on 30.08.2023.
//

import Foundation


enum HotelAssembler {
    static func assemble() -> HotelVC {
        let apiServices = ApiServices()
        let vc = HotelVC()
        let vm = HotelVM()
        vm.view = vc
        vm.apiService = apiServices
        vc.vm = vm
        return vc
    }
}
