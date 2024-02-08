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
    var move = 0
    var blankCard: Card
    var isEnd : Bool = false
    // private(set) can only read but can't write
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContentType) {
        cards = []
        cardCheck = []
        blankCard = Card(content: cardContentFactory(0))
        for pairIndex in 0..<numberOfCards {
            let content = cardContentFactory(pairIndex)
            var card = Card(content: content)
            if pairIndex == numberOfCards-1 {
                card.isBlank = true
                blankCard = card
            }
            cards.append(card)
            cardCheck.append(card)
        }
        cards.shuffle()
    }
    
    mutating func slide(_ card : Card) {
        if isEnd {
            return
        }
        
        let indexB = indexBlank()
        let indexC = index(of: card)
        var indexCheck: Array<Int> = [indexB-4, indexB-1, indexB+1, indexB+4]
        indexCheck = indexCheck.filter { $0 >= 0 && $0 < cards.count }
        if indexCheck.contains(indexC) {
            cards[indexC] = blankCard
            cards[indexB] = card
            move+=1
        }
        check()
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
    
    mutating private func check() {
        for index in 0..<cardCheck.count {
            if cards[index].id != cardCheck[index].id {
                return
            }
        }
        isEnd = true
    }
    
    func moveNumber() -> String {
        "\(move)"
    }
    
    func isGameEnd() -> Bool {
        return isEnd
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func startNewGame() {
        move = 0
        isEnd = false
        shuffle()
    }
    
    struct Card: Identifiable { // must use MemoryGameModel first before use this class ex. MemoryGameModel.Card(content: "")
        let content: CardContentType
        let id = UUID()
        var isBlank = false
    }
}
