//
//  ContentView.swift
//  Memory
//
//  Created by Stefan Le on 25.04.25.
//

import SwiftUI

struct ContentView: View {
    
    enum Theme: CaseIterable {
        case spooky
        case nature
        case space
        
        var emojis: [String] {
            switch self {
            case .spooky:
                return ["👻", "🎃", "🕸️", "🧛", "🕷️", "🧟", "🪦"]
            case .nature:
                return ["🌲", "🌻", "🌈", "🌼", "🍄", "🐝", "🐦"]
            case .space:
                return ["🚀", "🛸", "🌌", "👨‍🚀", "🪐", "🌕", "🌠"]
            }
        }
    }
    
    
    @State var activeTheme : Theme = .spooky

    
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            cards
            Spacer()
            themeSwitch
        }.padding()
    }
    
    var cards: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
                ForEach(0..<activeTheme.emojis.count, id: \.self){ index in
                    cardView(content: activeTheme.emojis[index]).aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
    }
    
    var themeSwitch : some View {
        HStack{
            ForEach(Theme.allCases, id: \.self) { theme in
                themeButton(name: theme)
            }
        }
    }
    
    func themeButton(name: Theme) -> some View {
        Button{
            activeTheme = name
        }label: {
            VStack{
                Text(name.emojis[0])
                Text(String(describing: name))
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
