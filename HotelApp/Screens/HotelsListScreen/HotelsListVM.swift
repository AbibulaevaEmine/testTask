//
//  HotelsListVM.swift
//  HotelApp
//
//  Created by admin on 31.08.2023.
//

import Foundation
import RxSwift

protocol PHotelsListVM {
    func getDataAboutRooms()
}

final class HotelsListVM: PHotelsListVM {
    var apiService: ApiServices?
    weak var view: PHotelsListVC?
    private let disposeBag = DisposeBag()
    
    func getDataAboutRooms() {
        apiService?.getDataForHotelRooms()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { data  in
                self.view?.model = data
                self.view?.reload()
            }, onFailure: { error in
                self.view?.showAlert(title: "Error", message: error.localizedDescription)
            }).disposed(by: disposeBag)
    }
}
