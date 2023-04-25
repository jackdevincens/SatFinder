//
//  SatelliteViewModel.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/20/23.
//

import Foundation

@MainActor
class SatViewModel: ObservableObject {
    @Published var satellitesArray: [RawSatellite] = []
    @Published var isLoading = false
    private var fileName = "active_satellites"
    
    private struct Returned: Codable {
        var name: String
        var satelliteId: String
    }
    
    func getRawData() async {
        print("Accessing Data from \(fileName)")
        isLoading = true
        guard let jsonData = try? Data(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "json")!) else {
            print("ERROR: Could not load JSON")
            isLoading = false
            return
        }

        // Then, use a JSONDecoder to decode the data into an array of RawSatellite structs
        let decoder = JSONDecoder()
        do {
            let returned = try decoder.decode([RawSatellite].self, from: jsonData)
            self.satellitesArray += returned
            isLoading = false
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            isLoading = false
        }
    }
}
