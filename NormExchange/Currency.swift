//
//  Currency.swift
//  NormExchange
//
//  Created by Dmitriy Eni on 23.05.22.
//

import Foundation
import ObjectMapper

class Currency: Mappable, CustomDebugStringConvertible {
    var id: Int!
    var abb: String!
    var scale: Double!
    var name: String!
    var rate: Double!
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id      <- map["Cur_ID"]
        abb     <- map["Cur_Abbreviation"]
        scale   <- map["Cur_Scale"]
        name    <- map["Cur_Name"]
        rate    <- map["Cur_OfficialRate"]
    }
    
    var debugDescription: String {
        return "\(abb!), \(rate!)\n"
    }
}
