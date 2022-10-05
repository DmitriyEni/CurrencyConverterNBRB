//
//  NBRBApi.swift
//  NormExchange
//
//  Created by Dmitriy Eni on 23.05.22.
//

import Foundation
import Moya

enum NBRBApi {
    case rate
}

extension NBRBApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.nbrb.by/api/")!
    }
    
    var path: String {
        switch self {
        case .rate:
            return "exrates/rates"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .rate:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        guard let params = parameters else { return .requestPlain }
        return .requestParameters(parameters: params, encoding: encoding)
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .rate:
            return URLEncoding.queryString
        }
    }
    
    var parameters: [String : Any]? {
        var params = [String : Any]()
        
        switch self {
        case .rate:
            params["periodicity"] = 0
        }
        
        return params
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
