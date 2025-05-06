//
//  EmojiMemoryGameView.swift
//  Memory
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    @Published private var model: MemoryGame<String> = createEmojiGame()
    
    
    private static func createEmojiGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairs: 8) { (index: Int) in
            if Theme.spooky.emojis.indices.contains(index) {
                return Theme.spooky.emojis[index]
            } else {
                return "N/A"
            }
        }
    }
    
    private enum Theme: CaseIterable {
        case spooky
        case nature
        case space
        
        var emojis: [String] {
            switch self {
            case .spooky:
                return ["👻", "🎃", "🕸️", "🧛", "🕷️", "🧟", "🪦"]
            case .nature:
                return ["🌲", "🌻", "🌈", "🌼", "🍄", "🐦"]
            case .space:
                return ["🚀", "🛸", "🪐", "🌕", "🌠"]
            }
        }
        var color: Color {
            switch self {
            case .spooky:
                    .black
            case .nature:
                    .green
            case .space:
                    .orange
            }
        }
    }
        
//    @State var activeTheme : Theme = .spooky
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }

    func chose(_ card: MemoryGame<String>.Card){
        model.chose(card: card)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
}
