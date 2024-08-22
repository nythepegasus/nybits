import Testing
import Foundation

@testable import nybits

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    #expect("Huh!".data().hexString == "48756821")
}
