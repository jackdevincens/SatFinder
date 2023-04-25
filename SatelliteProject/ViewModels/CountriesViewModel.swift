//
//  CountriesViewModel.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/22/23.
//

import Foundation

@MainActor
class CountriesViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var isLoading = false
    @Published var countryName = "n/a"
    
    var fileName = "satellites_by_country"
    
    func getData() async {
        print("Accessing Data from \(fileName)")
        isLoading = true
        guard let jsonData = try? Data(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "json")!) else {
            print("ERROR: Could not load JSON")
            isLoading = false
            return
        }

        // Then, use a JSONDecoder to decode the data into an array of Country structs
        let decoder = JSONDecoder()
        do {
            let returned = try decoder.decode([Country].self, from: jsonData)
            self.countries = returned
            isLoading = false
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    func returnCountry(satID: String) async {
        await getData()
        
        for country in self.countries {
            if country.satellites.contains(satID) {
                self.countryName = country.name.lowercased().capitalized
            }
        }
    }
}
