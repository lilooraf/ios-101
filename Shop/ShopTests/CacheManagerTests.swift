@testable import Shop
import XCTest

// Cache manager tests
//
// The goal of those tests are to check your cache implementation (eg: saving or retrieving data)
// Fill up those already created methods.
class CacheManagerTests: XCTestCase {

    let cacheManager = CacheManager()
    let key = "Test_Key"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cacheManager.save(0, forKey: "Soap")
        // Don't forget to delete / rewrite your data on the specific test key each time you run a test to avoid false negatives
    }

    func testSaveMockSuccessful() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let product = Product(id: "test", name: "Soap", image: "image", price_cents: 550, currency: "USD")
        var quantity = cacheManager.value(forKey: product.name, type: Int.self) ?? 0
        
        quantity += 1
        cacheManager.save(quantity, forKey: product.name)
        XCTAssert(cacheManager.value(forKey: product.name, type: Int.self) == 1)
    }

    func testGetMockFailure() throws {
        XCTAssert(true)
    }
}
