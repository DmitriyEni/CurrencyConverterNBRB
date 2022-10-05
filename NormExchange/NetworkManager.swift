//
//  NetworkManager.swift
//  NormExchange
//
//  Created by Dmitriy Eni on 23.05.22.
//

import Foundation
import Moya
import Moya_ObjectMapper

final class NetworkManager {
    static private let provider = MoyaProvider<NBRBApi>(plugins: [NetworkLoggerPlugin()])
    
    class func getRates(success: (([Currency]) -> ())?, failure: (() -> ())? = nil) {
        provider.request(.rate) { result in
            switch result {
            case .success(let response):
                guard let result = try? response.mapArray(Currency.self)
                else {
                    failure?()
                    return
                }
                success?(result)
            case .failure(_):
                print("гуляй, Вася")
                failure?()
            }
        }
    }
}
