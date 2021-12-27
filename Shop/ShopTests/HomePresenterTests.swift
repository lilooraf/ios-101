@testable import Shop
import XCTest

// Home Presenter tests
//
// The goal of those tests are to check your Home presenter implementation.
// Those tests will checks the behavior of the presenter when receiving a specific state
//
// Hint: DispatchQueue.main, Testing with expectation.
// Fill up those already created methods.
class HomePresenterTests: XCTestCase {

    lazy var presenter = DefaultHomePresenter(apiHandler: apiHandler)
    var view = MockHomeViewController()
    var apiHandler = MockAPIHandler()
    var product = Product(id: "test", name: "Soap", image: "image", price_cents: 550, currency: "USD")
    var shop = Shop(company_name: "company", products: [])
    override func setUpWithError() throws {
        presenter.view = view
    }

    func testViewDidLoadCallAPIHandler() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        view.apply(shop: shop)
        XCTAssert(view.applyCallCount == 1)
    }

    func testViewDidLoadCallAPIHandler_withSuccessResult() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let queue = DispatchQueue.main
        let expectation = expectation(description: "testViewDidLoadCallAPIHandler_withSuccessResult")

        let result: Result<Shop, NetworkError> = .success(shop)
        let tmpShop: Shop = (try result.get())
        view.apply(shop: self.shop)
        

        queue.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
        XCTAssert(tmpShop.company_name == shop.company_name)
    }

    func testViewDidLoadCallAPIHandler_withFailureNoDataResult() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let queue = DispatchQueue.main
        let expectation = expectation(description: "testViewDidLoadCallAPIHandler_withFailureNoDataResult")

        let result: Result<Shop, NetworkError> = .failure(.noData)

        queue.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        var message = ""
        do {
            _ = try result.get()
        } catch {
            message = "\(error)"
        }
        XCTAssert(message == "noData")
    }

    func testViewDidLoadCallAPIHandler_withFailureMalformedDataResult() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let queue = DispatchQueue.main
        let expectation = expectation(description: "testViewDidLoadCallAPIHandler_withFailureMalformedDataResult")

        let result: Result<Shop, NetworkError> = .failure(.malformedData)

        queue.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        var message = ""
        do {
            _ = try result.get()
        } catch {
            message = "\(error)"
        }
        XCTAssert(message == "malformedData")
    }

    func testViewDidLoadCallAPIHandler_withFailureErrorResult() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let queue = DispatchQueue.main
        let expectation = expectation(description: "testViewDidLoadCallAPIHandler_withFailureErrorResult")

        let customError = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "InvalidAccessToken"])
        let result: Result<Shop, NetworkError> = .failure(.error(customError))

        queue.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        var foundError = false
        do {
            _ = try result.get()
        } catch {
            foundError = true
        }
        XCTAssert(foundError)
    }
}
