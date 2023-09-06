//
//  ApiServices.swift
//  HotelTest
//
//  Created by admin on 30.08.2023.
//

import Foundation
import RxSwift

enum ApiCoders {
    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        return encoder
    }
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        
        return decoder
    }
}

struct APIData {
    let data: Data?
    let statusCode: Int
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}


final class ApiServices {
    func fetchData<Response: Decodable>(url: Endpoints) -> Observable<Response> {
        return Observable<Response>.create { observer -> Disposable in
            guard let url = URL(string: url.rawValue) else {
                observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(Response.self, from: data)
                    observer.onNext(model)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
