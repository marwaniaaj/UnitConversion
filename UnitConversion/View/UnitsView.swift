//
//  UnitsView.swift
//  UnitConversion
//
//  Created by Marwa Abou Niaaj on 29/09/2023.
//

import SwiftUI

struct UnitsView: View {
    @EnvironmentObject var dataProvider: DataProvider
    static let tag: String? = "Units"

    var body: some View {
        NavigationStack {
            List {
                ForEach(dataProvider.units, id: \.id) { unit in
                    NavigationLink(value: unit) {
                        HStack {
                            Image(systemName: unit.icon)
                                .font(.title2)
                                .frame(width: 32, height: 32)
                                .foregroundColor(Color.accentColor)

                            Text(LocalizedStringKey(unit.name))
                                .font(.title3)
                                .foregroundColor(.primary)

                            Spacer()
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Units")
            .navigationDestination(for: Unit.self) { unit in
                UnitConversionView(unit: unit)
            }
        }
    }
}

#Preview {
    UnitsView()
        .environmentObject(DataProvider.preview)
}
