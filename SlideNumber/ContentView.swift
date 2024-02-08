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
        RadialGradient(gradient: Gradient(stops:[
            .init(color: Color(UIColor(hex: "#78b9e4")), location: 0),
            .init(color: Color(UIColor(hex: "#44a4f1")), location: 0.35),
            .init(color: Color(UIColor(hex: "#2d93f0")), location: 0.5),
            .init(color: Color(UIColor(hex: "#2a6bb0")), location: 0.75),
            .init(color: Color(UIColor(hex: "#23466b")), location: 1)
        ]),center: .center, startRadius: 0, endRadius: 550)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    ZStack {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 350, height: 470)
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 350, height: 400)
                                .overlay(
                                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]){
                                        ForEach(viewModel.cards) { card in
                                            CardView(card)
                                                .aspectRatio(1, contentMode: .fit) // auto fix
                                                .onTapGesture {
                                                    viewModel.slide(card)
                                                }
                                        }
                                    }
                                        .padding(.bottom, 70)
                                        .padding(.horizontal)
                                )
                        }
                        VStack{
                            Spacer().frame(height: 370)
                            if viewModel.isGameEnd() {
                                Text("You Win!")
                                    .foregroundColor(Color(UIColor(hex: "#23466b")))
                                    .fontWeight(.bold)
                                    .font(.system(size: 25))
                                Text("total : \(viewModel.moveNumber()) moves")
                            }
                            else{
                                Text("Moves: \(viewModel.moveNumber())")
                                    .foregroundColor(Color(UIColor(hex: "#23466b")))
                                    .fontWeight(.bold)
                                .font(.system(size: 25))
                            }
                        }
                        VStack{
                            Text("Slide Number")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .font(.system(size: 60))
                            Spacer().frame(height: 680)
                        }
                        VStack{
                            Spacer()
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(UIColor(hex: "#23466b")))
                                .frame(width: 270, height: 80)
                                .overlay(
                                    Button("New Game"){
                                        viewModel.startNewGame()
                                    }
                                        .foregroundColor(Color.white)
                                        .fontWeight(.bold)
                                        .font(.system(size: 30))
                                )
                        }
                        
                    }
                        .padding()
                )
        
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
                    base.foregroundColor(Color(UIColor(hex: "#308BE5")))
                    Text(card.content)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
            }
        }
        
    }
}

// Extension to convert hex code to UIColor
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
