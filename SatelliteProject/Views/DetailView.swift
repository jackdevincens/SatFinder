//
//  DetailView.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/20/23.
//

import SwiftUI

struct DetailView: View {
    let satellite: Satellite
    
    var body: some View {
        VStack (alignment: .leading){
            Text(satellite.name)
                .font(.title)
                .bold()
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 2)
            
            Text(satellite.line1)
            
            Text(satellite.line2)
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(satellite: Satellite(name: "CENTAURI-2", line1: "1 43722U 18096D   22342.49258579  .00074897  00000+0  11887-2 0  9995", line2: "2 43722  97.3417  66.2842 0009901 136.2387 223.9653 15.53054583224948"))
    }
}
