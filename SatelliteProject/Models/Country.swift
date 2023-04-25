//
//  Country.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/22/23.
//

import Foundation

struct Country: Codable, Identifiable {
    let id = UUID().uuidString
    
    let name: String
    let satellites: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case satellites
    }
}
