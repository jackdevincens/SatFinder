//
//  ListView.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/20/23.
//

import SwiftUI

struct ListView: View {
    @StateObject var satVM = SatViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                List(satVM.satellitesArray) { satellite in
                    Text(satellite.name)
                }
                .listStyle(.plain)
                
                if satVM.isLoading {
                    ProgressView()
                }
            }
        }
        .task {
            await satVM.getData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
