//
//  EmojiMemoryGameView.swift
//  Memory
//
//  Created by Stefan Le on 25.04.25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel = EmojiMemoryGame()
   
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            card().animation(.default, value: viewModel.cards)
            Spacer()
            Button{
                viewModel.shuffle()
            }label: {
                Text("Shuffle")
            }
        }.padding()
    }
    
    
    func card() -> some View {
//        let number = Int.random(in: 1...activeTheme.emojis.count)
//        let slicedArray = activeTheme.emojis[0..<number]
//        var allPairs = slicedArray + slicedArray
//        allPairs.shuffle()
        
        
        return ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
                ForEach(0..<viewModel.cards.count, id: \.self){ index in
                    cardView(card: viewModel.cards[index]).aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
    }
}

struct cardView : View {
    let card: MemoryGame<String>.Card
    let color: Color = .orange
    
    var body : some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(color).foregroundStyle(color)
            Group{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white).padding(2)
                Text(card.content)
                    .font(.largeTitle)
            }.opacity(card.isFaceUp ? 1 : 0)
        }
    }
}


#Preview {
    EmojiMemoryGameView()
}

