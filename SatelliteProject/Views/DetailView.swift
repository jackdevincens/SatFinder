//
//  DetailView.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/20/23.
//

import SwiftUI

struct DetailView: View {
    @StateObject var countriesVM = CountriesViewModel()
    @StateObject var detailVM =  DetailViewModel()
    let satellite: RawSatellite
    @State private var countryName = "n/a"
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                Text(satellite.name)
                    .font(.title)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Spacer()
                
                Text(countriesVM.countryName)
                    .lineLimit(4)
                    .minimumScaleFactor(0.5)
            }
            .task {
                await countriesVM.returnCountry(satID: satellite.satelliteId)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 2)
            
            HStack (alignment: .top){
                Text("NORAD Catalog Number:")
                    .bold()
                
                Text(satellite.satelliteId)
            }
            
            Text("\(satellite.name) was the \(detailVM.satellite.launchNumber) launch of \(detailVM.satellite.launchYear)")
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            HStack (alignment: .top){
                Text("Orbit Inclination:")
                    .bold()
                
                Text("Inclination")
            }
            
            Text("It has completed \(detailVM.satellite.totalRevolutions) orbits as of \(detailVM.satellite.epoch)")
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
            
            Text("It completes \(detailVM.satellite.revolutionsPerDay) orbits around Earth every 24 hours.")
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            LocationView(satellite: satellite)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .task {
            detailVM.urlString = "https://api.n2yo.com/rest/v1/satellite/tle/\(satellite.satelliteId)&apiKey=DUR6WX-GQ7YC3-Z3QE4B-50R6"
            await detailVM.getData()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(satellite: RawSatellite(name: "CALSPHERE 2", satelliteId: "902"))
    }
}
