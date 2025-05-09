//
//  EmojiMemoryGameView.swift
//  Memory
//

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] = []
    private(set) var score: Int = 0
    
    private var seenSet = Set<Card>();
    
    init(numberOfPairs: Int, cardFactory: (_ position: Int) -> CardContent){
        for index in 0..<numberOfPairs {
            let content = cardFactory(index)
            cards.append(Card(content: content, id: "\(index)a"))
            cards.append(Card(content: content, id: "\(index)b"))
        }
        cards.shuffle()
    }
    
    struct Card: CustomStringConvertible, Equatable, Identifiable, Hashable{
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: String
        
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
        }
        
        func hash(into hasher: inout Hasher){
            hasher.combine(id)
        }
        
        var description: String {
            return "[\(content), \(isFaceUp ?  "up": "down"), \(isMatched)]"
        }
        
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
    
    mutating private func adjustScore(by offset: Int){
        score += offset
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
            adjustScore(by: 2)
        }
        
        if seenSet.contains(cards[chosenIndex]) || seenSet.contains(cards[existingOpenIndex]){
            adjustScore(by: -1)
        }
        
        cards[chosenIndex].isFaceUp = true
        
        if !seenSet.contains(card){
            seenSet.insert(card)
        }
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
