//
//  UnitConversionView.swift
//  UnitConversion
//
//  Created by Marwa Abou Niaaj on 30/09/2023.
//

import SwiftUI

struct UnitConversionView: View {
    @EnvironmentObject var dataProvider: DataProvider

    @State private var inputValue: Double
    @State private var inputUnit: Dimension
    @State private var outputUnit: Dimension

    var unit: Unit

    var unitTypes: [Dimension] {
        Unit.getUnitTypes(for: unit)
    }

    var isFavorite: Bool {
        if let _ = dataProvider.favorites.units?.filter({
            $0.convertFrom == inputUnit && $0.convertTo == outputUnit
        }).first {
            return true
        }
        return false
    }

    var outputNumber: String {
        let from = Measurement(value: inputValue, unit: inputUnit)
        let to = from.converted(to: outputUnit)
        return dataProvider.shortFormatter.string(from: to)
    }

    init(unit: Unit) {
        self.unit = unit
        self.inputValue = 10.0

        let types = Unit.getUnitTypes(for: unit)
        _inputUnit = State(wrappedValue: types[0])
        _outputUnit = State(wrappedValue: types[1])
    }

    init(unit: Unit, convertFrom: Dimension, convertTo: Dimension, value: Double) {
        self.unit = unit
        _inputValue = State(wrappedValue: value)
        _inputUnit = State(wrappedValue: convertFrom)
        _outputUnit = State(wrappedValue: convertTo)
    }

    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Convert from")
                        .font(.title3)

                    Spacer()

                    Menu {
                        Picker(selection: $inputUnit) {
                            ForEach(unitTypes, id: \.self) {
                                Text(dataProvider.longFormatter.string(from: $0).capitalized)
                            }
                        } label: {}
                    } label: {
                        Text(dataProvider.longFormatter.string(from: inputUnit).capitalized).bold()
                        + Text(" \(Image(systemName: "chevron.down"))")
                    }
                }

                HStack {
                    Text("Convert to")
                        .font(.title3)

                    Spacer()

                    Menu {
                        Picker(selection: $outputUnit) {
                            ForEach(unitTypes, id: \.self) {
                                Text(dataProvider.longFormatter.string(from: $0).capitalized)
                            }
                        } label: {}
                    } label: {
                        Text(dataProvider.longFormatter.string(from: outputUnit).capitalized).bold()
                        + Text(" \(Image(systemName: "chevron.down"))")
                    }
                }
            }

            Section {
                TextField("Input", value: $inputValue, format: .number)
                    .keyboardType(.decimalPad)
                    //.focused($amountIsFocused)
            } header: {
                Text("Amount to convert")
                    .font(.body)
                    .textCase(.none)
                    .foregroundColor(Color.accentColor)
            }

            Section {
                Text(outputNumber)
            } header: {
                Text("Result")
                    .font(.body)
                    .textCase(.none)
                    .foregroundColor(Color.accentColor)
            }
        }
        .navigationTitle(LocalizedStringKey(unit.name))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    toggleFavorite()
                } label: {
                    Label(
                        "Toggle favorite",
                        systemImage: isFavorite ? "star.fill" : "star"
                    )
                    .foregroundColor(Color.accentColor)
                }
            }
        }
    }

    private func toggleFavorite() {
        if !isFavorite {
            let fav = UnitConversion(
                convertFrom: inputUnit,
                convertTo: outputUnit,
                unit: unit.name,
                value: inputValue
            )
            dataProvider.addToFavorites(fav)
        } else {
            guard let fav = dataProvider.favorites.units?.filter({
                $0.convertFrom == inputUnit && $0.convertTo == outputUnit
            }).first else { return }
            dataProvider.removeFromFavorites(fav)
        }
    }
}

#Preview {
    NavigationStack {
        UnitConversionView(unit: DataProvider.preview.unitSample)
            .environmentObject(DataProvider.preview)
    }
}
