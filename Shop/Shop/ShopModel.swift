import Foundation

struct Shop: Codable {
    
    var company_name: String
    var products: [Product]
}

struct Product: Codable {

    var id: String
    var name: String
    var image: String
    var price_cents: Int
    var currency: String
}
