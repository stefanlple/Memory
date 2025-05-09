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
    
    private var existingOpenCardIndex: Int? {
        get{
            let matchingIndex = cards.indices.filter{index in !cards[index].isMatched && cards[index].isFaceUp}.only
            return matchingIndex
        }
        
        set{
            cards.indices.forEach { i in
                if i == newValue {
                    cards[i].isFaceUp = true
                } else {
                    if !cards[i].isMatched{
                        cards[i].isFaceUp = false
                    }
                }
            }
        }
    }
    
    mutating func chose(card: Card){
        guard let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) else {
            return
        }
        
        guard cards[chosenIndex].isFaceUp != true  && cards[chosenIndex].isMatched != true else {
            return
        }
    
        guard let existingOpenIndex = existingOpenCardIndex else {
            existingOpenCardIndex = chosenIndex
            return
        }
        
        if cards[existingOpenIndex].content == cards[chosenIndex].content {
            cards[existingOpenIndex].isMatched = true
            cards[chosenIndex].isMatched = true
        }
        
        cards[chosenIndex].isFaceUp = true
    }
            
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
}

extension Array {
    var only : Element?  {
        count == 1 ? first : nil
    }
}
