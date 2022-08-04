import Foundation

public class DataFetcher {

    public static func fetchCards(urlRequest: URL?, completion: @escaping (Cards?) -> Void) {
        Network.getData(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let cards = try JSONDecoder().decode(Cards.self, from: data)
                    completion(cards)
                } catch let jsonError {
                    print("Failed to decode JSON: \(jsonError)")
                }
            case .failure:
                completion(nil)
            }
        }
    }
}

