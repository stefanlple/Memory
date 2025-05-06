//
//  EmojiMemoryGameView.swift
//  Memory
//
//  Created by Stefan Le on 25.04.25.
//
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] = []
    
    init(numberOfPairs: Int, cardFactory: (_ position: Int) -> CardContent){
        for index in 0..<numberOfPairs {
            let content = cardFactory(index)
            cards.append(Card(content: content, id: "\(index)a"))
            cards.append(Card(content: content, id: "\(index)b"))
        }
        print(cards)
    }
    
    struct Card: CustomStringConvertible, Equatable, Identifiable{
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
        }
        
        var description: String {
            return "[\(content), \(isFaceUp ?  "up": "down"), \(isMatched)]"
        }
        
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
        var id: String
    }
    
    func chose(card: Card){
        
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
}
