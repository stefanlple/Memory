//
//  EmojiMemoryGameView.swift
//  Memory
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    @Published private var model: MemoryGame<String>
    
    private(set) var currentTheme: Theme
    
    init(themeName: String = "spooky"){
        currentTheme = EmojiMemoryGame.themes[themeName]!
        model = EmojiMemoryGame.createEmojiGame(using: currentTheme)
    }
    
    static private let themes: [String: Theme] = [
        "spooky": Theme(name: "spooky", color: .black, emojis: ["👻", "🎃", "🕸️", "🧛", "🕷️", "🧟", "🪦"], numberOfPairs: 4),
        "nature": Theme(name: "nature", color: .green, emojis: ["🌲", "🌻", "🌈", "🌼", "🍄", "🐦", "📷"], numberOfPairs: 5),
        "space": Theme(name: "space", color: .orange, emojis: ["🚀", "🛸", "🪐", "🌕", "🌠", "☄️", "👾"], numberOfPairs: 6)
    ]
    
    private static func createEmojiGame(using theme: Theme) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairs: min(theme.numberOfPairs, theme.emojis.count)) { index in
            if theme.emojis.indices.contains(index) {
                return theme.emojis[index]
            } else{
                return "N/A"
            }
            
        }
    }
    
     private func choseRandomTheme() {
         if let theme = EmojiMemoryGame.themes.values.randomElement() {
            currentTheme = theme
        }
    }
    
    struct Theme {
        let name: String
        let color: Color
        let emojis: [String]
        let numberOfPairs: Int
    }
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var score: String {
        String(model.score)
    }

    func chose(_ card: MemoryGame<String>.Card){
        model.chose(card: card)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func startNewGame(){
        choseRandomTheme()
        model = EmojiMemoryGame.createEmojiGame(using: currentTheme)
    }
}
