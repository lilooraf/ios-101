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
    override func setUpWithError() throws {
        presenter.view = view
    }

    func testViewDidLoadCallAPIHandler() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        XCTAssert(view.applyCallCount > 0 || view.displayErrorCallCount > 0)
    }

    func testViewDidLoadCallAPIHandler_withSuccessResult() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let queue = DispatchQueue.main
        let expectation = expectation(description: "testViewDidLoadCallAPIHandler_withSuccessResult")

        // let result: Result<Shop, NetworkError> = ...

        queue.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssert(view.applyCallCount > 0)
    }

    func testViewDidLoadCallAPIHandler_withFailureNoDataResult() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let queue = DispatchQueue.main
        let expectation = expectation(description: "testViewDidLoadCallAPIHandler_withFailureNoDataResult")

        // let result: Result<Shop, NetworkError> = .failure(.noData)

        queue.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssert(view.displayErrorCallCount > 0 && view.displayErrorMessage == "No data received")
    }

    func testViewDidLoadCallAPIHandler_withFailureMalformedDataResult() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let queue = DispatchQueue.main
        let expectation = expectation(description: "testViewDidLoadCallAPIHandler_withFailureMalformedDataResult")

        // let result: Result<Shop, NetworkError> = ...

        queue.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssert(view.displayErrorCallCount > 0 && view.displayErrorMessage == "Malformed data")
    }

    func testViewDidLoadCallAPIHandler_withFailureErrorResult() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let queue = DispatchQueue.main
        let expectation = expectation(description: "testViewDidLoadCallAPIHandler_withFailureErrorResult")
        //let result: Result<Shop, NetworkError> = 

        queue.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)

        XCTAssert(view.displayErrorCallCount > 0 && view.displayErrorMessage != "Malformed data" && view.displayErrorMessage == "No data received")
    }
}
