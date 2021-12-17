@testable import Shop
import XCTest

// Shop Model tests
//
// The goal of those tests are to check your Model decoding.
// You can use the two linked json files to help you achieve those tests.
// Hint: Bundle, Data

// Fill up those already created methods.
class ShopModelTests: XCTestCase {

    var bundle = Bundle(for: NetworkManagerTests.self)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testModelDecodingFromJSONFileShouldParseWithSuccess() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        guard let resource = bundle.url(forResource: "Shop", withExtension: "json") else {
            XCTFail()
            return
        }
       
        do {
            // Get data from ressource
            let data = try Data(contentsOf: resource)
            let jsonDecoder = JSONDecoder()
            
            // Parse Data
            let dataFromJson = try jsonDecoder.decode(Shop.self, from: data)
            
            // Verify company name
            XCTAssert(dataFromJson.company_name == "Savon de France", "company name is incorrect")
            
            // Verify the number of products
            XCTAssert(dataFromJson.products.count == 8, "the number of product isn't correct")
            
            // Verify values of first element
            XCTAssert(dataFromJson.products.first?.id == "aloe-vera-bar", "first product id incorrect")
            XCTAssert(dataFromJson.products.first?.name == "Aloe Vera Bar", "first product name incorrect")
            XCTAssert(dataFromJson.products.first?.image == "aloe-vera-bar", "first product image incorrect")
            XCTAssert(dataFromJson.products.first?.price_cents == 550, "first product price incorrect")
            XCTAssert(dataFromJson.products.first?.currency == "USD", "first product currency id incorrect")
            
        } catch {
            XCTFail("cannot get data from \(resource)")
        }
        
        // Get data from resource
        // Parse it
        // Asserts: Verify the company name, the number of products, values of the first element.
        // TODO: Assert
    }

    func testMalformedDataDecodingFromJSONFileShouldParseWithFailure() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        guard let resource = bundle.url(forResource: "MalformedShop", withExtension: "json") else {
            XCTFail()
            return
        }
        
        do {
            // Get data from ressource
            let data = try Data(contentsOf: resource)
            let jsonDecoder = JSONDecoder()
            
            // Parse Data
            _ = try jsonDecoder.decode(Shop.self, from: data)
            
        } catch {
            XCTAssert(true, "malformed data parse returned nil")
        }
        // Get data from resource
        // Parse it
        // Verify that decoding is failing and returning nil
        // TODO: Assert
    }
}
