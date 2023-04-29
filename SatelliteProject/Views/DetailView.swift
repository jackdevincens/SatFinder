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
                    .font(.custom("Orbitron-Medium", size: 24))
                    .foregroundColor(.yellow)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Spacer()
                
                Text(countriesVM.countryName)
                    .font(.custom("Orbitron-Regular", size: 16))
                    .foregroundColor(.yellow)
                    .lineLimit(4)
                    .minimumScaleFactor(0.5)
            }
            .task {
                await countriesVM.returnCountry(satID: satellite.satelliteId)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 2)
                .foregroundColor(.yellow)
            
            HStack (alignment: .top){
                Text("NORAD Catalog Number :")
                    .bold()
                
                Text(satellite.satelliteId)
            }
            .font(.custom("Orbitron-Regular", size: 18))
            .foregroundColor(.yellow)
            
            Text("\(satellite.name) was the \(detailVM.satellite.launchNumber) launch of \(detailVM.satellite.launchYear)")
                .font(.custom("Orbitron-Regular", size: 18))
                .foregroundColor(.yellow)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
            HStack (alignment: .top){
                Text("Orbit Inclination:")
                    .bold()
                
                Text("\(detailVM.satellite.inclination)")
            }
            .font(.custom("Orbitron-Regular", size: 18))
            .foregroundColor(.yellow)
            
            Text("It has completed \(detailVM.satellite.totalRevolutions) orbits as of \(detailVM.satellite.epoch)")
                .font(.custom("Orbitron-Regular", size: 18))
                .foregroundColor(.yellow)
                .lineLimit(3)
                .minimumScaleFactor(0.5)
            
            
            Text("It completes \(detailVM.satellite.revolutionsPerDay) orbits around Earth every 24 hours.")
                .font(.custom("Orbitron-Regular", size: 18))
                .foregroundColor(.yellow)
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
        .background(Image("background"))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(satellite: RawSatellite(name: "CALSPHERE 2", satelliteId: "902"))
    }
}
