import UIKit

class ViewController: UIViewController {

    private var game: MatchingGame? = nil
    
    private var numberOfPairsCard: Int {
        return (self.cardButtons.count + 1) / 2
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var emojiChoice = [String]()
    
    private var emojiSet = [Int:String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.game = MatchingGame(pairOfCards: self.numberOfPairsCard)
        self.cardButtons!.shuffle()
        self.emojiChoice = self.game!.getEmojiChoice()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cardPressed(_ sender: UIButton) {
        if let cardNumber = self.cardButtons.index(of: sender) {
            self.game!.chooseCard(at: cardNumber)
            self.updateViewFromModel()
        } else {
            print("not in array")
        }
        
        self.flipCountLabel.text = String("Flips:\(self.game!.flipCount)")
        self.scoreLabel.text = String("Scores:\(self.game!.score)")
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        for index in self.cardButtons.indices {
            let button = self.cardButtons[index]
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        self.emojiSet.removeAll(keepingCapacity: true)
        self.emojiChoice = self.game!.getEmojiChoice()
        self.cardButtons!.shuffle()
        
        self.game!.reset()
        self.flipCountLabel.text = String("Flips:\(self.game!.flipCount)")
        self.scoreLabel.text = String("Scores:\(self.game!.score)")
    }
    
    @IBAction func flipAllPressed(_ sender: UIButton) {
        self.game!.flipAll()
        self.updateViewFromModel()
        self.flipCountLabel.text = String("Flips:\(self.game!.flipCount)")
        self.scoreLabel.text = String("Scores:\(self.game!.score)")
    }
    
    private func updateViewFromModel() {
        for index in self.cardButtons.indices {
            let card = self.game!.cards[index]
            let button = self.cardButtons[index]
            
            if card.isFaceUp {
                button.setTitle(self.emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.454565654, blue: 0.3663207087, alpha: 1)
                
                if card.isMatched {
                    button.setTitle(self.emoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 0.6507482394)
                }
            } else {
                if card.isMatched {
                    button.setTitle(self.emoji(for: card), for: .normal)
                } else {
                    button.setTitle("", for: .normal)
                }
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 0.6507482394) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if self.emojiSet[card.identifier] == nil, emojiChoice.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(self.emojiChoice.count)))
            self.emojiSet[card.identifier] = self.emojiChoice.remove(at: randomIndex)
        }
        
        return self.emojiSet[card.identifier] ?? "?"
    }
}
