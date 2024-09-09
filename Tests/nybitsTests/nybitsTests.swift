import Testing
import Foundation

@testable import nybits

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    #expect("Huh!".data().hexString == "48756821")
}

@Test func rangeStuff() async throws {
    #expect(0..<2 == ~2)
    #expect(1..<2 == (1~2))
    #expect(2..<84 == (2~84))
}

@Test func testError() async throws {
    var error: Error? = nil
//    error = NSError(domain: "", code: 84)
    
    /**
     if let error = error {
        logError(error)
     } else { ... }
     */
    
    { err in
        print("Error!!! \(err.localizedDescription)")
        print("See we can do so much with this")
        print("A closure block allows us to do all sorts of cleanup on error catch")
    } <~| error |~> {
        print("All good!")
        print("And on success we know this closure block will run, since the error is nil")
    }
    
    /**
     What I love about the syntax above is that it feels like other language's idioms where it reads top down like a paragraph
     if the error exists it gets passed to the top closure, otherwise the bottom closure runs.
     I also made them discardableResult so the compiler doesn't complain about it being called like that
     
     It's like a little space ship :3
     */
    
    logError <~| error
    
    logError <~| error |~> {
        print("Succeeded!")
    }
    
    error |~> {
        print("Succeeded!")
    }
}
