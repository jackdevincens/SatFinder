//
//  LocationView.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/20/23.
//

import SwiftUI
import CoreLocation
import MapKit



struct LocationView: View {
    @StateObject var locVM = LocationViewModel()
    let satellite: RawSatellite
    @State var centerCoordinate = CLLocationCoordinate2D()
    @State var isShowingOverlays = true

    var body: some View {
        ZStack {
            VStack {
                MapView(centerCoordinate: $centerCoordinate)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 300)

                VStack {
                    Text("Current Location: \(locVM.locationName)")
                    
                    HStack {
                        Text("Latitude: \(locVM.latitude)")
                        Text("Longitude: \(locVM.longitude)")
                    }
                    
                    Text("Altitude: \(locVM.altitude) m")
                    
                    Button("Update Location") {
                        Task {
                            locVM.urlString = "https://api.n2yo.com/rest/v1/satellite/positions/\(satellite.satelliteId)/41.702/-76.014/0/1/&apiKey=\(APIKey)"
                            await locVM.getData()
                            centerCoordinate = CLLocationCoordinate2D(latitude: locVM.latitude, longitude: locVM.longitude)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }

            if locVM.isLoading {
                ProgressView()
                    .scaleEffect(4)
            }
        }
        .task {
            locVM.urlString = "https://api.n2yo.com/rest/v1/satellite/positions/\(satellite.satelliteId)/41.702/-76.014/0/1/&apiKey=\(APIKey)"
            await locVM.getData()
            centerCoordinate = CLLocationCoordinate2D(latitude: locVM.latitude, longitude: locVM.longitude)
        }
    }
}


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(satellite: RawSatellite(name: "Orsted", satelliteId: "25635"))
            .environmentObject(LocationViewModel())
    }
}
