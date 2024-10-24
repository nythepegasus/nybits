//
//  NB+Decodable.swift
//  nybits
//
//  Created by ny on 10/24/24.
//

import Foundation

// MARK: Decodable Data json extensions

public extension Decodable {
    init?(json: Data) {
        if let d = try? JSONDecoder().decode(Self.self, from: json) {
            self = d
        } else { return nil }
    }
    
    init?(json: Data, handleError: @escaping (Error) -> Void) {
        do { self = try JSONDecoder().decode(Self.self, from: json)
        } catch { handleError(error); return nil }
    }
    
    init?(json: Data, handleError: @escaping ErrorHandler<Data>) {
        do { self = try JSONDecoder().decode(Self.self, from: json)
        } catch { handleError(error, json); return nil }
    }
    
    init?(json: Data, handleError: @escaping ErrorHandler<String?>) {
        do { self = try JSONDecoder().decode(Self.self, from: json)
        } catch { handleError(error, String(data: json, encoding: .utf8)); return nil }
    }
}

public extension Decodable where Self: HasErrorHandler<Data> {
    init?(json: Data, handleError: @escaping ErrorHandler<Data> = Self.handleError) {
        do { self = try JSONDecoder().decode(Self.self, from: json)
        } catch { handleError(error, json); return nil }
    }
    
    init?(json: Data) { self.init(json: json, handleError: Self.handleError) }
    // explicit init with handler to ensure it exists/compiles
}
