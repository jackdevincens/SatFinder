//
//  LocationSatellite.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/20/23.
//

import Foundation

struct LocationSatellite: Codable {
    var satlatitude: Double
    var satlongitude: Double
    var sataltitude: Double
    
    enum CodingKeys: CodingKey {
        case satlatitude, satlongitude, sataltitude
    }
}
