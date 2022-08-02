import UIKit

public func buildURL(with name: String) -> String {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.magicthegathering.io"
    components.path = "/v1/cards"
    components.queryItems = [URLQueryItem(name: "name", value: name)]
    return components.url?.absoluteString ?? ""
}

let url = buildURL(with: "Black Lotus|Opt")

func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)

    guard let url = urlRequest else  {
        print("Invalid URL")
        return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            if (error as! URLError).code == URLError.notConnectedToInternet {
                switch (error as! URLError).code {
                case URLError.resourceUnavailable:
                    print("A requested resource couldn’t be retrieved")
                case URLError.badServerResponse:
                    print("URL Loading System received bad data from the server")
                case URLError.networkConnectionLost:
                    print("A client or server connection was severed in the middle of an in-progress load")
                default:
                    print("Unknown error")
                }
            }
        } else if let response = response as? HTTPURLResponse {
            print("Server status = \(response.statusCode)")

            guard let data = data else { return }

            do {
                let сardsData = try JSONDecoder().decode(Cards.self, from: data).cards
                print("""
                        Card name: \(String(describing: сardsData.first?.name ?? ""))
                        Mana cost: \(String(describing: сardsData.first?.manaCost ?? ""))
                        Type: \(String(describing: сardsData.first?.type ?? ""))
                        Rarity: \(String(describing: сardsData.first?.rarity ?? ""))
                        Set name: \(String(describing: сardsData.first?.setName ?? ""))
                        --------------------
                        """)
            } catch {
                print("jsonError")
            }
        }
    }.resume()
}

getData(urlRequest: url)
