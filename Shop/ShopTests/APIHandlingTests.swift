@testable import Shop
import XCTest

// API Handler tests
//
// The goal of those tests are to check your api handler implementation.
// In this case, we want to see that the API handler is actually calling the network manager.
// Fill up those already created methods.
class APIHandlingTests: XCTestCase {

    let networkManager = MockNetworkManager()
    lazy var apiHandler = APIHandler(networkManager: networkManager)

    func testShouldCallNetworkingManagerWhenFetchShopCalled() throws {
        apiHandler.fetchShop { res in
            switch res {
                case .success(let shop):
                    XCTAssertNotNil(shop, "Success")
                case .failure(let error):
                    XCTFail("Unexpected error \(error)")
                }
        }
    }
}
