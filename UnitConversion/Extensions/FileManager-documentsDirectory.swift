//
//  FileManager-documentsDirectory.swift
//  UnitConversion
//
//  Created by Marwa Abou Niaaj on 29/09/2023.
//  Reference: https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory

import Foundation

extension FileManager {

    /// Default document directory URL in user domain
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
