import Foundation

public func buildURL(with name: String) -> String {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.magicthegathering.io"
    components.path = "/v1/cards"
    components.queryItems = [URLQueryItem(name: "name", value: name)]
    return components.url?.absoluteString ?? ""
}

let url = buildURL(with: "Black Lotus|Opt")

public class Network {

    public static func getData(urlRequest: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = urlRequest else { fatalError("Unknown error occurred") }

        let configuration: URLSessionConfiguration = .default
        configuration.allowsCellularAccess = true
        configuration.waitsForConnectivity = true

        let session = URLSession(configuration: configuration)

        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error - \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print("Server status -  \(response.statusCode)\n")
            } else if let response = response as? HTTPURLResponse {
                print("Server response error -  \(response.statusCode)")
                return
            }

            guard let data = data else {
                print("No data")
                return
            }

            completion(.success(data))
        }.resume()
    }

    public static func makeRequestUrl(baseURL: String, path: String, queryItems: [URLQueryItem]?) -> URL? {
        guard let baseURL = URL(string: baseURL) else { return nil }

        let requestURL: URL

        if path.isEmpty {
            requestURL = baseURL
        } else {
            requestURL = baseURL.appendingPathComponent(path)
        }

        if let queryItems = queryItems {
            var urlComponents = URLComponents(string: requestURL.absoluteString)
            urlComponents?.queryItems = queryItems

            guard let newRequestURL = urlComponents?.url else {
                return nil
            }

            return newRequestURL
        }
        return requestURL
    }
}
