//
//  ConvertedSatellite.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/20/23.
//

import Foundation

struct ConvertedSatellite: Identifiable {
    var id = UUID().uuidString
    
    var catalogNumber = ""
    var classification = ""
    var launchYear = ""
    var launchNumber = ""
    var epoch = ""
    var inclination = "" //write func to convert inclination to pro/retro
    var revolutionsPerDay = ""
    var totalRevolutions = ""
}
