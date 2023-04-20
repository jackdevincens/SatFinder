//
//  SatelliteViewModel.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/20/23.
//

import Foundation

@MainActor
class SatViewModel: ObservableObject {
    //@Published var satellitesArray: [ConvertedSatellite] = []
    @Published var rawSatellitesArray: [Satellite] = []
    @Published var view: SatelliteView?
    @Published var isLoading = false
    @Published var urlString = "https://tle.ivanstanojevic.me/api/tle/"
    
    private struct Returned: Codable {
        var member: [Satellite]
        var view: SatelliteView
    }
    
    func getData() async {
        print("Accessing Data from \(urlString)")
        isLoading = true
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create url from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let returned = try decoder.decode(Returned.self, from: data)
            self.satellitesArray = returned.member
            self.view = returned.view
            isLoading = false
        } catch {
            print("ERROR: \(error.localizedDescription)")
            isLoading = false
        }
    }

}
