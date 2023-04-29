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
                    HStack (alignment: .top) {
                        Text("Current Location: ")
                            .font(.custom("Orbitron-Regular", size: 16))
                            .bold()
                        Text("\(locVM.locationName)")
                            .font(.custom("Orbitron-Regular", size: 16))
                    }
                    .foregroundColor(.yellow)
                    
                    HStack (alignment: .top) {
                        Text("Latitude: ")
                            .font(.custom("Orbitron-Regular", size: 16))
                            .bold()
                        Text("\(locVM.latitude)")
                            .font(.custom("Orbitron-Regular", size: 16))
                    }
                    .foregroundColor(.yellow)
                    
                    HStack (alignment: .top) {
                        Text("Longitude: ")
                            .font(.custom("Orbitron-Regular", size: 16))
                            .bold()
                        Text("\(locVM.longitude)")
                            .font(.custom("Orbitron-Regular", size: 16))
                    }
                    .foregroundColor(.yellow)
                    
                    HStack (alignment: .top) {
                        Text("Altitude: ")
                            .font(.custom("Orbitron-Regular", size: 16))
                            .bold()
                        Text("\(locVM.altitude) m")
                            .font(.custom("Orbitron-Regular", size: 16))
                    }
                    .foregroundColor(.yellow)
                    
                    Button("Update Location") {
                        Task {
                            locVM.urlString = "https://api.n2yo.com/rest/v1/satellite/positions/\(satellite.satelliteId)/41.702/-76.014/0/1/&apiKey=\(APIKey)"
                            await locVM.getData()
                            centerCoordinate = CLLocationCoordinate2D(latitude: locVM.latitude, longitude: locVM.longitude)
                        }
                    }
                    .font(.custom("Orbitron-Regular", size: 16))
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
