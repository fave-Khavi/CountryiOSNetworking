//
//  Country.swift
//  iOSNetworking
//
//  Created by khavishini suresh on 14/06/2022.
//

import Foundation

struct Country: Decodable {
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}



