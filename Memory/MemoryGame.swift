//
//  EmojiMemoryGameView.swift
//  Memory
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
        
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: String
    }
    
    private var existingOpenCardIndex: Int?
    
    mutating func chose(card: Card){
        guard let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) else {
            return
        }
        
        guard let existingOpenIndex = existingOpenCardIndex  else {
            cards[chosenIndex].isFaceUp = true
            existingOpenCardIndex = chosenIndex
            return
        }
        
        if cards[existingOpenIndex].content == cards[chosenIndex].content {
            cards[existingOpenIndex].isMatched = true
            cards[chosenIndex].isFaceUp = true
            cards[chosenIndex].isMatched = true
        } else {
            for index in cards.indices {
                if cards[index].isMatched != true {
                    cards[index].isFaceUp = false
                }
            }
        }
        existingOpenCardIndex = nil
    }
        
        
//        if let comparedCard = existingOpenCard {
//            if comparedCard.content == card.content {
//                card.isFaceUp = true
//                card.isMatched = true
//                existingOpenCard?.isMatched = true
//            }else{
//                cards.filter{_ in card.isMatched != true}.map{card in card.isFaceUp = false}
//                
//            }
//        }else {
//            existingOpenCard = card
//        }
// chose a card
// check if the card is the only card
// check for content of the
//    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
}
