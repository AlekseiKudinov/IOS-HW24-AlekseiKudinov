import Foundation

public struct Cards: Decodable {
    public let cards: [Card]
}

public struct Card: Decodable {
    public let name: String
    public let manaCost: String?
    public let type: String?
    public let rarity: String?
    public let setName: String?
}

