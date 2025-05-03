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
    
    
    @State var activeTheme : Theme = .spooky

    
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            card()
            Spacer()
            themeSwitch
        }.padding()
    }
    
    
    func card() -> some View {
        let number = Int.random(in: 1...activeTheme.emojis.count)
//        let number = 6
        let slicedArray = activeTheme.emojis[0..<number]
        var allPairs = slicedArray + slicedArray
        allPairs.shuffle()
        
        return GeometryReader { geometry in
            let totalWidth = geometry.size.width
            
            let widthThatBestFit: CGFloat = {
                let column: Int = switch number {
                case 1...2:
                    2
                case 3...4:
                    3
                default:
                    4
                }
                
                return (totalWidth - (CGFloat(column + 1) * 2)) / CGFloat(column)
            }()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFit))]) {
                    ForEach(0..<allPairs.count, id: \.self) { index in
                        cardView(content: allPairs[index], color: activeTheme.color)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .padding(.horizontal)
            }
        }
        }
//        return ScrollView{
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
//                ForEach(0..<allPairs.count, id: \.self){ index in
//                    cardView(content: allPairs[index], color: activeTheme.color).aspectRatio(2/3, contentMode: .fit)
//                }
//            }
//        }
//    }
    
    var themeSwitch : some View {
        HStack{
            Spacer()
            ForEach(Theme.allCases, id: \.self) { theme in
                themeButton(name: theme)
                Spacer()
            }
        }
    }
    
    func themeButton(name: Theme) -> some View {
        Button{
            activeTheme = name
        }label: {
            VStack{
                Text(name.emojis[0]).font(.title3)
                Text(String(describing: name)).font(.caption)
            }
        }
    }
    
    
}

struct cardView : View {
    let content: String
    let color: Color
    @State var isFaceUp = true
    
    var body : some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(color).foregroundStyle(color)
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
