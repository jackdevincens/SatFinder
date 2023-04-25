//
//  Satellite.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/24/23.
//

import Foundation

struct Satellite: Identifiable {
    var id = UUID().uuidString
    
    var name = ""
    var catalogNumber = ""
    var classification = ""
    var launchYear = ""
    var launchNumber = ""
    var epoch = ""
    var inclination = ""
    var revolutionsPerDay = ""
    var totalRevolutions = ""
}
