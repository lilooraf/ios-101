@testable import Shop
import XCTest

// Detail Presenter tests
//
// The goal of those tests are to check your Home presenter implementation.
// Those tests will checks the behavior of the presenter and its interaction with the cache.
//
// Hint: DispatchQueue.main, Testing with expectation.
// Fill up those already created methods.
class DetailPresenterTests: XCTestCase {

    var presenter: DetailPresenter!
    var view = MockDetailViewController()
    var cacheManager = MockCacheManager()
    var product = Product(id: "test", name: "Soap", image: "image", price_cents: 550, currency: "USD")

    override func setUpWithError() throws {
        presenter = DefaultDetailPresenter(cacheManager: cacheManager, product: product)
        presenter.view = view
    }

    func testViewDidLoad_applyProduct() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        view.apply(product: product, quantity: 1)
        XCTAssert(view.applyCallCount == 1)
    }

    func testViewDidLoad_checkCacheForQuantity() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        cacheManager.save(0, forKey: product.name)
        XCTAssert(cacheManager.saveCallCount == 1)
    }

    func testDidTapAddButton_callSaveCacheManager() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        presenter.didTapAddButton()
        XCTAssert(cacheManager.saveCallCount == 1)
    }

    func testDidTapAddButton_applyProductAndQuantity() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        presenter.didTapAddButton()
        XCTAssert(view.applyQuantity == 1)
    }

    func testDidTapRemoveButton_callSaveCacheManager() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        presenter.didTapRemoveButton()
        XCTAssert(cacheManager.saveCallCount == 1)
    }

    func testDidTapRemoveButton_applyProductAndQuantity() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        presenter.didTapRemoveButton()
        XCTAssert(view.applyQuantity == 0)
    }
}
