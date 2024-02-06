//
//  SlideNumberGameModel.swift
//  SlideNumber
//
//  Created by นางสาวชลิศา ธรรมราช on 6/2/2567 BE.
//

import Foundation

struct SlideNumberGameModel<CardContentType> {
    var cards: Array<Card>
    var cardCheck : Array<Card>
    var round = 0
    var blankCard: Card
    // private(set) can only read but can't write
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContentType) {
        cards = []
        cardCheck = []
        blankCard = Card(content: cardContentFactory(0))
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            var card = Card(content: content)
            if pairIndex == numberOfPairsOfCards-1 {
                card.isBlank = true
                blankCard = card
            }
            cards.append(card)
            cardCheck.append(card)
        }
        cards.shuffle()
    }
    
    mutating func slide(_ card : Card) {
        
    }
    
    private func indexBlank() -> Int {
        return index(of: blankCard)
    }
    
    private func index(of card: Card) -> Int {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0
    }
    
    private func check() -> Bool {
        for index in 0..<cardCheck.count {
            if cards[index].id != cardCheck[index].id {
                return false
            }
        }
        return true
    }
    
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Identifiable { // must use MemoryGameModel first before use this class ex. MemoryGameModel.Card(content: "")
        let content: CardContentType
        let id = UUID()
        var isBlank = false
    }
}
