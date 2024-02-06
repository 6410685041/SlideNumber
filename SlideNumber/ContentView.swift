//
//  ContentView.swift
//  SlideNumber
//
//  Created by นางสาวชลิศา ธรรมราช on 6/2/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = NumberViewModel()
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]){
                            ForEach(viewModel.cards) { card in
                                CardView(card)
                                    .aspectRatio(1, contentMode: .fit) // auto fix
                            }
                        }
        }
        .padding()
    }
}

struct CardView: View {
    var card: SlideNumberGameModel<String>.Card
    
    init(_ card: SlideNumberGameModel<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack{
            if !card.isBlank{
                let base = RoundedRectangle(cornerRadius: 12)
                
                Group {
                    base.foregroundColor(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(card.content)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
