//
//  NumberViewModel.swift
//  SlideNumber
//
//  Created by นางสาวชลิศา ธรรมราช on 6/2/2567 BE.
//

import Foundation

class NumberViewModel: ObservableObject {
    static let number = ["1", "2", "3", "4",
                         "5", "6", "7", "8",
                         "9", "10", "11", "12",
                         "13", "14", "15", ""]
    
    // if something chage in this , it will be announced
    @Published private var model = SlideNumberGameModel<String>(numberOfPairsOfCards: number.count) {
        index in number[index]
    }
    
    var cards: [SlideNumberGameModel<String>.Card] { // .card
        return model.cards
    }
    
    func shuffle() { // .shuffle()
        model.shuffle()
    }
    
//    func choose(_ card: SlideNumberGameModel<String>.Card) {
//        model.choose(card)
//    }
}
