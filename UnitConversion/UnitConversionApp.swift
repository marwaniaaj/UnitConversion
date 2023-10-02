//
//  UnitConversionApp.swift
//  UnitConversion
//
//  Created by Marwa Abou Niaaj on 29/09/2023.
//

import SwiftUI

@main
struct UnitConversionApp: App {

    @StateObject var archiver: Archiver
    @StateObject var dataProvider: DataProvider

    init() {
        let archiver = Archiver()
        _archiver = StateObject(wrappedValue: archiver)

        let dataProvider = DataProvider(archiver: archiver)
        _dataProvider = StateObject(wrappedValue: dataProvider)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataProvider)
        }
    }
}
