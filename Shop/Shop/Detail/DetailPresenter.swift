import Foundation

protocol DetailPresenterView: AnyObject {
    func apply(product: Product, quantity: Int)
}

class DefaultDetailPresenter: DetailPresenter {
    weak var view: DetailPresenterView?
    var product: Product
    var cacheManager: CacheManaging

    init(cacheManager: CacheManaging, product: Product) {
        self.cacheManager = cacheManager
        self.product = product
    }

    func viewDidLoad() {
        let quantity = cacheManager.value(forKey: product.name, type: Int.self) ?? 0

        view?.apply(product: product, quantity: quantity)
    }

    func didTapAddButton() {
        var quantity = cacheManager.value(forKey: product.name, type: Int.self) ?? 0
        
        quantity += 1
        cacheManager.save(quantity, forKey: product.name)
        view?.apply(product: product, quantity: quantity)
    }

    func didTapRemoveButton() {
        var quantity = cacheManager.value(forKey: product.name, type: Int.self) ?? 0
        
        if (quantity > 0) {
            quantity -= 1
        }
        cacheManager.save(quantity, forKey: product.name)
        view?.apply(product: product, quantity: quantity)
    }
}

struct ProductQuantity: Codable {
    let quantity: Int
}
