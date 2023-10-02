//
//  FavoritesView.swift
//  UnitConversion
//
//  Created by Marwa Abou Niaaj on 29/09/2023.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var dataProvider: DataProvider

    var groupedFavorite: [[UnitConversion]] {
        Dictionary(
            grouping: dataProvider.favorites.units ?? [UnitConversion](),
            by: { $0.unit }
        )
        .sorted(by: {$0.key < $1.key})
        .map { $0.value }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedFavorite, id: \.self) { groupedConversions in
                    Section {
                        ForEach(groupedConversions) { conversion in
                            NavigationLink(value: conversion) {
                                HStack {
                                    Text(dataProvider.longFormatter.string(from: conversion.convertFrom).capitalized)

                                    Spacer()

                                    Image(systemName: "arrow.right")
                                        .foregroundColor(Color.accentColor)

                                    Spacer()

                                    Text(dataProvider.longFormatter.string(from: conversion.convertTo).capitalized)
                                }
                            }
                        }
                    } header: {
                        Text(groupedConversions[0].unit)
                            .font(.title3)
                            .textCase(.none)
                            .foregroundColor(Color.accentColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 4)
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationDestination(for: UnitConversion.self) { conversion in
                UnitConversionView(
                    unit: getUnit(conversion.unit),
                    convertFrom: conversion.convertFrom,
                    convertTo: conversion.convertTo,
                    value: conversion.value
                )
            }
        }
    }

    func getUnit(_ name: String) -> Unit {
        dataProvider.units.filter { $0.name == name}.first!
    }
}

#Preview {
    NavigationStack {
        FavoritesView()
            .environmentObject(DataProvider.preview)
    }
}