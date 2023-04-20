//
//  Satellite.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/20/23.
//

import Foundation

struct Satellite: Codable, Identifiable {
    let id = UUID().uuidString
    
    var name = ""
    var line1 = ""
    var line2 = ""
    
    enum CodingKeys: String, CodingKey {
        case name, line1, line2
    }
}
