//
//  JSONHandler.swift
//  JSONHandler
//
//  Created by Štěpán Friedl on 21.03.2024.
//

import SwiftUI

public class JSONHandler {
    public static func parseJSON<T: Codable>(_ json: Data, using: T.Type, catchHandler: ((Error) -> ())? = nil) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: json)
        } catch {
            if let catchHandler = catchHandler { catchHandler(error) }
            return nil
        }
    }
    
    public static func encodeJSON<T: Codable>(_ request: T, catchHandler: ((Error) -> Void)? = nil) -> String? {
        do {
            return String(data: try JSONEncoder().encode(request), encoding: .utf8)
        } catch {
            if let catchHandler = catchHandler {
                catchHandler(error)
            }
            return nil
        }
    }
}
