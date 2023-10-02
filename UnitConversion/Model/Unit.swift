//
//  Unit.swift
//  UnitConversion
//
//  Created by Marwa Abou Niaaj on 29/09/2023.
//

import Foundation

/// An object representing the unit of measures, and unit types.
/// 
/// All unit types are from [Units and Measurement](https://developer.apple.com/documentation/foundation/units_and_measurement)
class Unit: NSObject, Identifiable, Codable {
    var id: UUID { UUID() }
    var name: String
    var icon: String

    static let unitTypes = [
        "Area": [
            UnitArea.squareKilometers,
            UnitArea.squareMeters,
            UnitArea.squareCentimeters,
            UnitArea.squareInches,
            UnitArea.squareFeet,
            UnitArea.squareMiles,
            UnitArea.squareYards,
            UnitArea.acres,
            UnitArea.hectares
        ],
        "Length": [
            UnitLength.kilometers,
            UnitLength.meters,
            UnitLength.centimeters,
            UnitLength.millimeters,
            UnitLength.inches,
            UnitLength.feet,
            UnitLength.yards,
            UnitLength.miles
        ],
        "Volume": [
            UnitVolume.fluidOunces,
            UnitVolume.cups,
            UnitVolume.quarts,
            UnitVolume.pints,
            UnitVolume.liters,
            UnitVolume.milliliters,
            UnitVolume.teaspoons,
            UnitVolume.tablespoons,
        ],
        "Mass": [
            UnitMass.kilograms,
            UnitMass.grams,
            UnitMass.milligrams,
            UnitMass.ounces,
            UnitMass.pounds
        ],
        "Speed": [
            UnitSpeed.kilometersPerHour,
            UnitSpeed.milesPerHour,
            UnitSpeed.metersPerSecond
        ],
        "Temperature": [
            UnitTemperature.fahrenheit,
            UnitTemperature.celsius,
            UnitTemperature.kelvin
        ]
    ]

    /// Get array of unit types filtered by given unit.
    /// - Parameter unit: Parent unit for filtering the array.
    /// - Returns: `[Dimension]` containing unit types.
    static func getUnitTypes(for unit: Unit) -> [Dimension] {
        return unitTypes.filter({ $0.key == unit.name }).first?.value ?? [Dimension]()
    }
}
