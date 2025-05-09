//
//  EmojiMemoryGameView.swift
//  Memory
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel = EmojiMemoryGame()
   
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            Text(viewModel.currentTheme.name).font(.largeTitle)
            Text(viewModel.score).font(.largeTitle)
            card().animation(.default, value: viewModel.cards )
            Spacer()
            HStack{
                Button{
                    viewModel.shuffle()
                }label: {
                    Text("Shuffle")
                }
                Spacer()
                Button{
                    viewModel.startNewGame()
                }label: {
                    Text("New Game")
            }
            }
        }.padding()
    }
    
    
    func card() -> some View {
        return ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
                ForEach(viewModel.cards){ card in
                    cardView(card: card, color: viewModel.currentTheme.color).aspectRatio(2/3, contentMode: .fit).onTapGesture {
                        viewModel.chose(card)
                    }
                }
            }
        }
    }
}

struct cardView : View {
    let card: MemoryGame<String>.Card
    let color: AnyShapeStyle
    
    
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
        }.opacity(card.isMatched ? 0 : 1).animation(.easeInOut(duration: 1), value: card.isMatched)
    }
}


#Preview {
    EmojiMemoryGameView()
}
