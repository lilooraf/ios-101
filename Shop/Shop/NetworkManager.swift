import Foundation

enum NetworkError: Error, Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData):
            return true
        case (let .error(error1), let error(error2)):
            return error1.localizedDescription == error2.localizedDescription
        case (.malformedData, .malformedData):
              return true
        default:
            return false
        }
    }

    case noData
    case error(Error)
    case malformedData
}

// Excercise: Create a networking manager to fetch data from an API endpoint
//
// Requirement:
// - Use URLSession for this excercise.
// - Return a NetworkError if error occurs or not data.
//
// Hint: Decodable, URLSession, URLSessionConfiguration, Decoder
protocol NetworkManaging {
    func data<T: Decodable>(from url: URL, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

public class NetworkManager: NetworkManaging {
    
    let session: URLSession
    let jsonDecoder: JSONDecoder

    init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
        jsonDecoder = JSONDecoder()
    }

    func data<T: Decodable>(from url: URL, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = session.dataTask(with: url) { [self] data, response, error -> Void in
            do {
                let dataFromJson = try jsonDecoder.decode(Shop.self, from: data!)
                completion(Result<T, NetworkError>.success(dataFromJson as! T))
            } catch {
                completion(Result<T, NetworkError>.failure(NetworkError.malformedData))
            }
        }
        task.resume()
    }
}
