import Foundation

public struct Cards: Decodable {
    public let cards: [Card]
}

public struct Card: Decodable {
    let name: String
    let manaCost: String?
    let type: String
    let rarity: String
    let setName: String
    let artist: String
    let power: String?

    public static func cardsData(_ card: Card) {
        guard card.name == "Opt" || card.name == "Black Lotus" else { return }

        print("""
        Card name: \(card.name)
        Type: \(card.type)
        Rarity: \(card.rarity)
        Set name: \(card.setName)
        Author: \(card.artist)
        """)

        if let manaCost = card.manaCost {
            print("Mana cost: \(manaCost)")
        }

        if let power = card.power {
            print("Power: \(power)")
        }

        print("--------------------------------")
    }
}


