import Foundation

struct Card {
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    var isFaceUp: Bool = false
    
    var isMatched: Bool = false
    
    var times: Int = 0
    
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        
        return Card.identifierFactory
    }
}
