//
//  Archiver.swift
//  UnitConversion
//
//  Created by Marwa Abou Niaaj on 29/09/2023.
//

import Foundation

/// A class responsible for managing unit conversions.
/// Including archiving and writing data into document directory,
/// Unarchiving and loading data into conversions array.
final class Archiver: NSObject, ObservableObject {

    /// Encode and archive given favorites, and save it in given url path
    /// - Parameters:
    ///   - favorites: Favorite unit conversion
    ///   - url: URL containing file path
    /// - Returns: Bool
    func archiveUnits(_ favorites: Conversions, in url: URL) {
        do {
            // Encodes an object graph with the given root object into a data representation.
            let data = try NSKeyedArchiver.archivedData(withRootObject: favorites, requiringSecureCoding: true)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            print("Data successfully archived")
        } catch {
            print("Data failed to archive. \(error): \(error.localizedDescription)")
        }
    }

    /// Retrieve and decode favorites from given url path
    /// - Parameter url: URL containing file path
    /// - Returns: Unarchived and decoded Conversions.
    func retrieveUnits(from url: URL) -> Conversions? {
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }

        do {
            let data = try Data(contentsOf: url)

            // Decodes a previously-archived object graph, and returns the root object as the specified type.
            guard let unarchived = try NSKeyedUnarchiver.unarchivedObject(ofClass: Conversions.self, from: data) else {
                return nil
            }
            return unarchived
        }
        catch {
            print("Error retrieving data. \(error): \(error.localizedDescription)")
            return nil
        }
    }
}
