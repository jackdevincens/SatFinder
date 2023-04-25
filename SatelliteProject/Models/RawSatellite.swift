//
//  RawSatellite.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/24/23.
//

import Foundation

struct RawSatellite: Codable, Identifiable {
    let id = UUID().uuidString
    
    var name = ""
    var satelliteId = ""
    
    enum CodingKeys: String, CodingKey {
        case name, satelliteId
    }
}
