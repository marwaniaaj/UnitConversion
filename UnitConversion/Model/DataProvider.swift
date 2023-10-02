//
//  DataProvider.swift
//  UnitConversion
//
//  Created by Marwa Abou Niaaj on 30/09/2023.
//

import Foundation

class DataProvider: ObservableObject {

    @Published var archiver: Archiver
    @Published var units = [Unit]()
    @Published var favorites = Conversions()

    private let favoritesUrl = FileManager
        .documentsDirectory
        .appendingPathComponent("Favorites.archive")

    @Published private(set) var longFormatter = MeasurementFormatter()
    @Published private(set) var shortFormatter = MeasurementFormatter()

    init(archiver: Archiver) {
        self.archiver = archiver

        loadUnits()
        retrieveFavorites()
        configureFormatters()
    }
    
    /// Configure measurement formatters for localized representation of units.
    private func configureFormatters() {
        longFormatter.unitOptions = .providedUnit
        longFormatter.unitStyle = .long

        shortFormatter.unitOptions = .providedUnit
        shortFormatter.unitStyle = .medium
    }

    private func loadUnits() {
        units = Bundle.main.decode([Unit].self, from: "Units.json")
    }

    private func retrieveFavorites() {
        if let favs = archiver.retrieveUnits(from: favoritesUrl) {
            favorites = favs
        } else {
            emptyFavoriteUnits()
        }
    }

    private func archiveFavorites() {
        archiver.archiveUnits(favorites, in: favoritesUrl)
        retrieveFavorites()
    }

    /// Empty array data
    private func emptyFavoriteUnits() {
        favorites.units = []
    }

    /// Add given `UnitConversion` into favorite conversions array.
    /// - Parameter unit: `UnitConversion` to be added to conversions array
    func addToFavorites(_ unit: UnitConversion) {
        favorites.units?.append(unit)
        archiveFavorites()
    }

    /// Remove given `UnitConversion` from favorite conversion array.
    /// - Parameter unit: `UnitConversion` to be removed to conversions array
    func removeFromFavorites(_ unit: UnitConversion) {
        guard let index = favorites.units?.firstIndex(of: unit) else { return }
        favorites.units?.remove(at: index)
        archiveFavorites()
    }
}

// MARK: - Preview
extension DataProvider {

    static var preview: DataProvider = {
        let dataProvider = DataProvider(archiver: Archiver())
        dataProvider.favorites = Conversions()
        return dataProvider
    }()

    var unitSample: Unit { units[0] }
}
