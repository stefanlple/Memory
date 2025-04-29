//
//  ContentView.swift
//  Memory
//
//  Created by Stefan Le on 25.04.25.
//

import SwiftUI

struct ContentView: View {
    var emojiArray = ["😀", "🐶", "🍕", "🚗", "🏀", "🎸", "📱", "🎁"]
    @State var cardCount = 4
    @State private var text: String = "Enter text here..."
    
    var body: some View {
        VStack{
            cards
            Spacer()
            cardCountAdjuster
        }.padding()
    }
    
    var cards: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
                ForEach(0..<cardCount, id: \.self){ index in
                    cardView(content: emojiArray[index]).aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
    }
    
    func adjustCardCountButton(offset: Int, content: String) -> some View {
        Button{
            cardCount += offset
        } label: {
            Image(systemName: content)
        }.disabled(cardCount + offset < 1 || cardCount + offset > emojiArray.count)
    }
    
    var cardCountAdjuster : some View {
        HStack{
            removeButton
            Spacer()
            addButton
        }.padding()
    }
    
    var removeButton : some View {
        adjustCardCountButton(offset: -1, content: "minus.circle")
    }
    
    var addButton : some View {
        adjustCardCountButton(offset: 1, content: "plus.circle")
    }
}

struct cardView : View {
    let content: String
    @State var isFaceUp = false
    
    var body : some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.orange).foregroundStyle(Color.orange)
            Group{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white).padding(2)
               Text(content)
                   .font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}


#Preview {
    ContentView()
}
