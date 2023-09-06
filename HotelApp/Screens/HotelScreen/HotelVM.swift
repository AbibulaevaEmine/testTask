//
//  HotelVM.swift
//  HotelApp
//
//  Created by admin on 30.08.2023.
//

import Foundation
import RxSwift

protocol PHotelVM {
    func getData()
    var model: HotelDTO? { get }
}

final class HotelVM: PHotelVM {
    var apiService: ApiServices? 
    weak var view: PHotelVC?
    private let disposeBag = DisposeBag()
    var model: HotelDTO?
    
    func getData() {
        apiService?.getDataForHotel()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { data in
                self.model = data
                self.view?.reload()
            }, onFailure: { error in
                self.view?.showAlert(title: "Error", message: error.localizedDescription)
            }).disposed(by: disposeBag)
    }
}
