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
        NavigationStack {
            List(satVM.satellitesArray) { satellite in
                NavigationLink {
                    DetailView(satellite: satellite)
                } label: {
                    Text(satellite.name)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Satellites")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Shuffle") {
                        satVM.satellitesArray.shuffle()
                    }
                }
                
                ToolbarItem(placement: .status) {
                    Text("\(satVM.satellitesArray.count) Satellites")
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button("Search") {
                        
                    }
                }
            }
        }
        .task {
            await satVM.getRawData()
        }

    }
}
//        NavigationStack {
//            ZStack {
//                List(satVM.satellitesArray) { satellite in
//                    LazyVStack {
//                        NavigationLink {
//                            DetailView(satellite: satellite)
//                        } label: {
//                            Text(satellite.name)
//                        }
//                    }
//                }
//                .listStyle(.plain)
//                .navigationTitle("Satellites")
//                .toolbar {
//                    ToolbarItem(placement: .status) {
//                        Text("\(satVM.satellitesArray.count)/\(satVM.totalSatelliteCount) Loaded")
//                    }
//                }
//
//                if satVM.isLoading {
//                    ProgressView()
//                        .scaleEffect(4)
//                }
//            }
//        }
//        .task {
//            await satVM.getRawData()
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
