#  Unit Conversion

> This project is a demonstration of how to securely encode/decode custom objects that have properties of types that do not conform to `Codable` protocol.


## Project overview
A Simple unit conversion app using [Apple's Units and Measurement APIs](https://developer.apple.com/documentation/foundation/units_and_measurement), to convert between measurement units -`Dimension`, using `.converted(to:)` to produce the required result.
We have array of units (Area, Length, Mass, etc..), map of unit types -`Dimension` in each unit -`[String, [Dimension]]`,  and we have list of favorite conversions, these favorites will be persisted in Document Directory folder, for easy access.


## References
- [How to store NSCoding data using Codable](https://www.hackingwithswift.com/example-code/language/how-to-store-nscoding-data-using-codable)
- [Object Persistence in Swift with NSSecureCoding](https://betterprogramming.pub/object-persistence-in-swift-with-nssecurecoding-8955ec69662e#:~:text=The%20NSSecureCoding%20protocol%20is%20a,be%20encoded%20and%20decoded%20securely.)
- [How to use NSSecureCoding in Swift](https://onmyway133.com/posts/how-to-use-nssecurecoding-in-swift/)
- [NSSecureCoding](https://developer.apple.com/documentation/foundation/nssecurecoding)

## Build and Install

### Requirements
- iOS 16.2+
- Xcode 15
- Swift 5.9
