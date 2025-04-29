//
//  ContentView.swift
//  Memory
//
//  Created by Stefan Le on 25.04.25.
//

import SwiftUI

struct ContentView: View {
  
    
    @State var activeTheme = 0
    
    
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            cards
            Spacer()

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
