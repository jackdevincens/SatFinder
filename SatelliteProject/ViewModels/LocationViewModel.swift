//
//  LocationViewModel.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/20/23.
//

import Foundation
import CoreLocation
import MapKit

@MainActor
class LocationViewModel: ObservableObject {
    @Published var satID = ""
    @Published var isLoading = false
    @Published var latitude = 0.0
    @Published var longitude = 0.0
    @Published var altitude = 0.0
    @Published var locationName = ""
    @Published var urlString = ""
    
    private struct Returned: Codable {
        var positions: [LocationSatellite]
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
            let returned = try decoder.decode(Returned.self, from: data)
            self.latitude = returned.positions[0].satlatitude
            self.longitude = returned.positions[0].satlongitude
            self.altitude = returned.positions[0].sataltitude
            let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
            do {
                let placemarks = try await CLGeocoder().reverseGeocodeLocation(location)
                
                if let placemark = placemarks.first {
                    var name = ""
                    if let country = placemark.country {
                        name = country
                    } else if let ocean = placemark.ocean {
                        name = ocean
                    } else {
                        name = "Unknown location"
                    }
                    self.locationName = name
                }
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
            isLoading = false
        } catch {
            print("ERROR: \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    private func getLocationName() async throws {
        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let geocoder = CLGeocoder()
        
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        
        if let placemark = placemarks.first {
            var name = ""
            if let locality = placemark.locality {
                name += locality
            }
            if let administrativeArea = placemark.administrativeArea {
                if !name.isEmpty {
                    name += ", "
                }
                name += administrativeArea
            }
            if let country = placemark.country {
                if !name.isEmpty {
                    name += ", "
                }
                name += country
            }
            self.locationName = name
        }
    }
}
