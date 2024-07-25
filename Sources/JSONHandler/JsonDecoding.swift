//
//  JsonDecoding.swift
//  Krudtteltet
//
//  Created by Štěpán Friedl on 25.07.2024.
//

import Foundation

extension KeyedDecodingContainer {
    public static func decode<KeyType: CodingKey, T: Decodable>(container: KeyedDecodingContainer<KeyType>, forKey key: KeyType, type: T.Type, catchHandler: ((Error, String, String) -> Void)? = nil) -> T? {
         if container.contains(key) {
              do {
                  return try container.decode(type.self, forKey: key)
              } catch {
                  if let catchHandler = catchHandler {
                      catchHandler(error, "\(T.self)", "\(key)")
                  }
                   return nil
              }
         } else {
              return nil
         }
    }
    
    public static func decodeInt<KeyType: CodingKey>(container: KeyedDecodingContainer<KeyType>, forKey key: KeyType, catchHandler: ((Error, String, String) -> Void)? = nil, callerClassName: String? = nil) -> Int? {
         if container.contains(key) {
              do {
                   if let integerString = try? container.decode(String.self, forKey: key),
                      let integer = Int(integerString) {
                        return integer
                   } else {
                        return try container.decode(Int.self, forKey: key)
                   }
              } catch {
                  if let catchHandler = catchHandler {
                      catchHandler(error, callerClassName ?? "unknown class", "\(key)")
                  }
                   return nil
              }
         } else {
              return nil
         }
    }
    
    public static func decodeDouble<KeyType: CodingKey>(container: KeyedDecodingContainer<KeyType>, forKey key: KeyType, catchHandler: ((Error, String, String) -> Void)? = nil, callerClassName: String? = nil) -> Double? {
         if container.contains(key) {
              do {
                   if let doubleString = try? container.decode(String.self, forKey: key),
                      let double = Double(doubleString) {
                        return double
                   } else {
                        return try container.decode(Double.self, forKey: key)
                   }
              } catch {
                  if let catchHandler = catchHandler {
                      catchHandler(error, callerClassName ?? "unknown class", "\(key)")
                  }
                   return nil
              }
         } else {
              return nil
         }
    }
    
    public static func decodeString<KeyType: CodingKey>(container: KeyedDecodingContainer<KeyType>, forKey key: KeyType, catchHandler: ((Error, String, String) -> Void)? = nil, callerClassName: String? = nil) -> String? {
        if container.contains(key) {
            if let string = try? container.decode(String.self, forKey: key) {
                return string
            } else if let integer = try? container.decode(Int.self, forKey: key) {
                return "\(integer)"
            } else if let double = try? container.decode(Double.self, forKey: key) {
                return "\(double)"
            } else if let boolean = try? container.decode(Bool.self, forKey: key) {
                return "\(boolean)"
            } else {
                let error = DecodeStringError.typeMismatch(key)
                if let catchHandler = catchHandler {
                    catchHandler(error, callerClassName ?? "unknown class", "\(key)")
                }
                return nil
            }
         } else {
              return nil
         }
    }
    
    public static func decodeBool<KeyType: CodingKey>(container: KeyedDecodingContainer<KeyType>, forKey key: KeyType, catchHandler: ((Error, String, String) -> Void)? = nil, callerClassName: String? = nil) -> Bool? {
         if container.contains(key) {
              do {
                   if let boolString = try? container.decode(String.self, forKey: key),
                      let bool = Bool(boolString) {
                        return bool
                   } else {
                        return try container.decode(Bool.self, forKey: key)
                   }
              } catch {
                  if let catchHandler = catchHandler {
                      catchHandler(error, callerClassName ?? "unknown class", "\(key)")
                  }
                   return nil
              }
         } else {
              return nil
         }
    }
}

public enum DecodeStringError<KeyType: CodingKey>: Error {
    case keyNotFound(KeyType)
    case typeMismatch(KeyType)
    case unknown(KeyType)
}
