import Foundation

class MatchingGame {
    
    init(pairOfCards: Int) {
        for _ in 1...pairOfCards {
            let card = Card()
            self.cards += [card, card]
        }
        
        self.emojiType = [
            self.emojiChoice1,
            self.emojiChoice2,
            self.emojiChoice3,
            self.emojiChoice4,
            self.emojiChoice5,
            self.emojiChoice6
        ]
        self.emojiType.shuffle()
    }
    
    var cards: [Card] = []
    
    var flipCount: Int = 0
    
    var score: Int = 0
    
    private var emojiChoice1 = ["☮️","✝️","☪️","🕉","☸️","✡️","🔯","🕎"]
    private var emojiChoice2 = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼"]
    private var emojiChoice3 = ["🐠","🐟","🐬","🐳","🐋","🦈","🐊","🦀"]
    private var emojiChoice4 = ["💁‍♀️","🙅‍♀️","🙆‍♀️","🙋‍♀️","🤦‍♀️","🤷‍♀️","🙎‍♀️","🙍‍♀️"]
    private var emojiChoice5 = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇"]
    private var emojiChoice6 = ["👩‍👧‍👦","👩‍👦‍👦","👩‍👧‍👧","👨‍👧‍👦","👨‍👦‍👦","👨‍👧‍👧","👪","👨‍👩‍👧"]
    private var emojiType = [[String]]()
    
    var isFlipAll: Bool = true
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in self.cards.indices {
                if !self.cards[index].isFaceUp {
                    continue
                }
                
                if foundIndex == nil {
                    foundIndex = index
                } else {
                    return nil
                }
            }
            
            return foundIndex
        }
        
        set(newValue) {
            for index in self.cards.indices {
                self.cards[index].isFaceUp = (index == newValue)
                if index == newValue {
                    cards[index].times += 1
                }
            }
        }
    }
    
    func getEmojiChoice() -> [String] {
        return self.emojiType[0]
    }
    
    func chooseCard(at index: Int) {
        if !self.cards[index].isMatched { // 已經match的牌不進入
            if let matchIndex = self.indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if self.cards[matchIndex].identifier == cards[index].identifier {
                    self.cards[matchIndex].isMatched = true
                    self.cards[index].isMatched = true
                    
                    self.cards[matchIndex].times = 0
                    self.cards[index].times = 0
                    
                    self.score += 2
                } // matched
                
                self.cards[index].isFaceUp = true
                
                // 處理次數
                self.cards[index].times += 1
                
                // 檢查扣分
                if self.cards[index].isFaceUp && !self.cards[index].isMatched && self.cards[index].times > 1 {
                    self.score -= 1
                }
                
                if self.cards[matchIndex].isFaceUp && !self.cards[matchIndex].isMatched && self.cards[matchIndex].times > 1 {
                    self.score -= 1
                }
            } else if let matchIndex = self.indexOfOneAndOnlyFaceUpCard, matchIndex == index { // 點在已經翻過的牌要翻回去
                self.cards[index].isFaceUp = false
                self.indexOfOneAndOnlyFaceUpCard = nil
                
                // 檢查扣分
                if self.cards[index].times > 1 {
                    self.score -= 1
                }
            } else {
                self.indexOfOneAndOnlyFaceUpCard = index
            }
            
            self.flipCount += 1
        }
    }
    
    func reset() {
        for index in self.cards.indices {
            self.cards[index].isMatched = false
            self.cards[index].isFaceUp = true
        }
        
        self.flipCount = 0
        self.score = 0
        self.isFlipAll = true
        self.emojiType.shuffle()
    }
    
    func flipAll() {
        if self.isFlipAll {
            for index in self.cards.indices {
                self.cards[index].isMatched = true
                self.cards[index].isFaceUp = true
            }
        } else {
            for index in self.cards.indices {
                self.cards[index].isMatched = false
                self.cards[index].isFaceUp = false
            }
        }
        
        self.score = 0
        self.flipCount = 0
        self.isFlipAll = !self.isFlipAll
    }
}
