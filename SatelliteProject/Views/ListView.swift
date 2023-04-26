//
//  ListView.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/20/23.
//
//  Comment to push to new repo

import SwiftUI

struct ListView: View {
    @StateObject var satVM = SatViewModel()
    @State private var searchText = ""
    @FocusState private var textFieldIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            List(filteredSatellites) { satellite in
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
                    Text("")
                }
                
                ToolbarItem(placement: .status) {
                    Text("\(filteredSatellites.count) Satellites")
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        satVM.satellitesArray.shuffle()
                        textFieldIsFocused = false
                    } label: {
                        Image(systemName: "shuffle")
                    }
                    
                }
            }
        }
        .task {
            await satVM.getRawData()
        }
        .searchable(text: $searchText, prompt: "Search")
        
    }
    
    
    var filteredSatellites: [RawSatellite] {
        if searchText.isEmpty {
            return satVM.satellitesArray
        } else {
            return satVM.satellitesArray.filter { satellite in
                satellite.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
