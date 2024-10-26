//
//  NB+Decodable.swift
//  nybits
//
//  Created by ny on 10/24/24.
//

import Foundation

// MARK: Decodable Data json extensions

public extension Decodable {
    init(json: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: json)
    }
    
    init(json: Data?) throws {
        self = try JSONDecoder().decode(Self.self, from: json ?? Data())
    }

    init(json: Data, errorHandler: @escaping EmptyErrorHandler = {}) throws {
        do {self = try JSONDecoder().decode(Self.self, from: json)
            return
        } catch { errorHandler() }
        self = try JSONDecoder().decode(Self.self, from: json)
    }
    
    init(json: Data, errorHandler: @escaping ErrorHandler = { _ in }) throws {
        do {self = try JSONDecoder().decode(Self.self, from: json)
            return
        } catch { errorHandler(error) }
        self = try JSONDecoder().decode(Self.self, from: json)
    }
    
    init(json: Data, errorHandler: @escaping ThrowingEmptyErrorHandler = {}) rethrows {
        do {self = try JSONDecoder().decode(Self.self, from: json)
            return
        } catch { try errorHandler() }
        self = try! JSONDecoder().decode(Self.self, from: json)
    }
    
    init(json: Data, errorHandler: @escaping ThrowingErrorHandler = { _ in }) rethrows {
        do {self = try JSONDecoder().decode(Self.self, from: json)
            return
        } catch { try errorHandler(error) }
        self = try! JSONDecoder().decode(Self.self, from: json)
    }
}
    
public extension Decodable {
    init?(_ json: Data) {
        guard let d = try? JSONDecoder().decode(Self.self, from: json) else { return nil }
        self = d
    }
    
    init?(_ json: Data, errorHandler: @escaping ErrorHandler) {
        do { self = try JSONDecoder().decode(Self.self, from: json)
        } catch { errorHandler(error); return nil }
    }
    
    init?(_ json: Data, errorHandler: @escaping EmptyErrorHandler) {
        do { self = try JSONDecoder().decode(Self.self, from: json)
        } catch { errorHandler(); return nil }
    }
    
    
    init?(_ json: Data, errorHandler: @escaping @autoclosure ThrowingEmptyErrorHandler) rethrows {
        do { try self.init(json: json, errorHandler: errorHandler)
        } catch { try errorHandler(); return nil }
    }
}

public extension Decodable {
    init?(_ json: Data?) {
        guard let json = json else { return nil }
        guard let d = try? JSONDecoder().decode(Self.self, from: json) else { return nil }
        self = d
    }
    
    init?(json: Data?, errorHandler: @escaping ErrorHandler) throws {
        guard let json = json else { return nil }
        try self.init(json: json, errorHandler: errorHandler)
    }
    
    init?(json: Data?, errorHandler: @escaping EmptyErrorHandler) throws {
        guard let json = json else { return nil }
        try self.init(json: json, errorHandler: errorHandler)
    }
    
    init?(json: Data?, errorHandler: @escaping @autoclosure ThrowingEmptyErrorHandler) rethrows {
        guard let json = json else { return nil }
        try self.init(json: json, errorHandler: errorHandler)
    }
}

public extension Decodable where Self: HasErrorLogger<Data> {
    init(json: Data, errorHandler: @escaping ErrorLogger<Data> = Self.handleError(_:_:)) throws {
        do {self = try JSONDecoder().decode(Self.self, from: json)
            return
        } catch { errorHandler(error, json) }
        self = try JSONDecoder().decode(Self.self, from: json)
    }
}

public extension Decodable where Self: HasThrowingErrorLogger<Data> {
    init(json: Data, errorHandler: @escaping ThrowingErrorLogger<Data> = Self.handleError(error:_:)) rethrows {
        do {self = try JSONDecoder().decode(Self.self, from: json)
            return
        } catch { try errorHandler(error, json) }
        self = try! JSONDecoder().decode(Self.self, from: json)
    }
}

public extension Decodable where Self: HasErrorHandler {
    init(json: Data, errorHandler: @escaping ErrorHandler = Self.handleError(_:)) throws {
        do {self = try JSONDecoder().decode(Self.self, from: json)
            return
        } catch { errorHandler(error) }
        self = try JSONDecoder().decode(Self.self, from: json)
    }
}

public extension Decodable where Self: HasThrowingErrorHandler {
    init(json: Data, errorHandler: @escaping ThrowingErrorHandler = Self.handleError(error:)) rethrows {
        do {self = try JSONDecoder().decode(Self.self, from: json)
            return
        } catch { try errorHandler(error) }
        self = try! JSONDecoder().decode(Self.self, from: json)
    }
}

public extension Decodable where Self: HasEmptyErrorHandler {
    init(json: Data, errorHandler: @escaping EmptyErrorHandler = Self.handleError) throws {
        do {self = try JSONDecoder().decode(Self.self, from: json)
            return
        } catch { errorHandler() }
        self = try JSONDecoder().decode(Self.self, from: json)
    }
}

public extension Decodable where Self: HasThrowingEmptyErrorHandler {
    init(json: Data, errorHandler: @escaping ThrowingEmptyErrorHandler = Self.HandleError) rethrows {
        do {self = try JSONDecoder().decode(Self.self, from: json)
            return
        } catch { try errorHandler() }
        self = try! JSONDecoder().decode(Self.self, from: json)
    }
}
