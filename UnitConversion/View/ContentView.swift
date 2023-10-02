//
//  ContentView.swift
//  UnitConversion
//
//  Created by Marwa Abou Niaaj on 29/09/2023.
//

import SwiftUI

struct ContentView: View {
    //@SceneStorage("selectedView") var selectedView: String?

    var body: some View {
        TabView(/*selection: $selectedView*/) {
            UnitsView()
                //.tag(HomeView.tag)
                .tabItem {
                    Image(systemName: "lines.measurement.horizontal")
                    Text("Units")
                }

            FavoritesView()
                //.tag(FavoritesView.tag)
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataProvider.preview)
}
