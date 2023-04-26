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
            .font(.title3)
            
            Text("\(satellite.name) was the \(detailVM.satellite.launchNumber) launch of \(detailVM.satellite.launchYear)")
                .font(.title3)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            HStack (alignment: .top){
                Text("Orbit Inclination:")
                    .bold()
                
                Text("\(detailVM.satellite.inclination)")
            }
            .font(.title3)
            
            Text("It has completed \(detailVM.satellite.totalRevolutions) orbits as of \(detailVM.satellite.epoch)")
                .font(.title3)
                .lineLimit(3)
                .minimumScaleFactor(0.5)
            
            
            Text("It completes \(detailVM.satellite.revolutionsPerDay) orbits around Earth every 24 hours.")
                .font(.title3)
                .lineLimit(3)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            LocationView(satellite: satellite)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .task {
            detailVM.urlString = "https://api.n2yo.com/rest/v1/satellite/tle/\(satellite.satelliteId)&apiKey=\(APIKey)"
            await detailVM.getData()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(satellite: RawSatellite(name: "CALSPHERE 2", satelliteId: "902"))
    }
}
