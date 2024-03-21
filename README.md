# JSONHandler

JSONHandler is a Swift package designed to simplify the process of encoding and decoding JSON data using Codable protocols in SwiftUI applications.

## Installation

To integrate JSONHandler into your Xcode project, add it as a dependency in your `Package.swift` file:

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/StepanFriedl/JSONHandler.git", from: "1.0.0")
    ],
    // ...
)
```
Then, in the target's dependencies section, add "JSONHandler".
```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "JSONHandler", package: "JSONHandler"),
    ]
),
```

## Usage
Import the JSONHandler module wherever you plan to use it:
```swift
import JSONHandler
```

## Parsing JSON
Use the parseJSON method to decode JSON data into Swift objects conforming to the Codable protocol:
```swift
if let jsonData = jsonString.data(using: .utf8) {
    if let decodedObject: YourObjectType = JSONHandler.parseJSON(jsonData, using: YourObjectType.self) {
        // Successfully decoded the JSON into YourObjectType
    } else {
        // Failed to decode JSON
    }
}
```

## Encoding JSON
Use the encodeJSON method to encode Swift objects conforming to the Codable protocol into JSON data:
```swift
let objectToEncode = YourObjectType(...)
if let jsonString = JSONHandler.encodeJSON(objectToEncode) {
    // Successfully encoded the object into JSON string
} else {
    // Failed to encode object
}
```

## Error Handling
Both parseJSON and encodeJSON methods support optional error handling. You can provide a closure to catch and handle any errors that occur during encoding or decoding:
```swift
let objectToEncode = YourObjectType(...)
if let jsonString = JSONHandler.encodeJSON(objectToEncode, catchHandler: { error in
    // Handle encoding error here
}) {
    // Successfully encoded the object into JSON string
} else {
    // Failed to encode object
}
```
```swift
if let jsonData = jsonString.data(using: .utf8) {
    if let decodedObject: YourObjectType = JSONHandler.parseJSON(jsonData, using: YourObjectType.self, catchHandler: { error in
        // Handle decoding error here
    }) {
        // Successfully decoded the JSON into YourObjectType
    } else {
        // Failed to decode JSON
    }
}
```

## License
JSONHandler is available under the MIT license. See the LICENSE file for more info.
