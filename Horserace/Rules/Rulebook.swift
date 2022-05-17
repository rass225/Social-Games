import Foundation
import SwiftUI

struct RuleBook {
    
    let horseRace: [HorseRaceRule] = [
        HorseRaceRule(image: Images.Nr.one, title: "Objective", rule: "The general idea is to pick a horse that you think would win the race."),
        HorseRaceRule(image: Images.Nr.two, title: "Pick a Suit", rule: "Pick a suit that you would think would come up on top."),
        HorseRaceRule(image: Images.Nr.three, title: "Bet", rule: "Place your bet. Each sip of your drink represents one bet. If you win, you get to give out double."),
        HorseRaceRule(image: Images.Nr.four, title: "Setup", rule: "4 aces, representing each suit, will be lined up to start a race."),
        HorseRaceRule(image: Images.Nr.five, title: "Start", rule: "A card will be drawn from the deck. An ace, that has a matching suit with that card, will be moved forward to the next base."),
        HorseRaceRule(image: Images.Nr.six, title: "Game", rule: "One by one cards will be drawn from the deck. Each time an appropriate ace will be moved forward to the next base"),
        HorseRaceRule(image: Images.Nr.seven, title: "Penalty", rule: "If all four aces have reached certain base, a penalty card will be flipped. Depending on the suit of the penalty card, corresponding ace will be moved back by one base"),
        HorseRaceRule(image: Images.Nr.eight, title: "Game over", rule: "The game is over, when the first ace reaches the finish line"),
        HorseRaceRule(image: Images.Nr.nine, title: "Winner", rule: "The players who's horce(suit) won, can give out double amount of sips")
    ]
    
    let kingsCup: [KingsCupRules] = [
        KingsCupRules(deck: Deck(suit: .diamond, rank: .ace, icon: Images.diamond), title: "Waterfall", rule: "Everyone drinks, staring with you. A player can end drinking when the previous player does"),
        KingsCupRules(deck: Deck(suit: .heart, rank: .two, icon: Images.heart), title: "You", rule: "Pick someone to take a drink"),
        KingsCupRules(deck: Deck(suit: .clubs, rank: .three, icon: Images.club), title: "Me", rule: "Take a drink"),
        KingsCupRules(deck: Deck(suit: .spades, rank: .four, icon: Images.spade), title: "Whores", rule: "Ladies take a drink"),
        KingsCupRules(deck: Deck(suit: .diamond, rank: .five, icon: Images.diamond), title: "Drive", rule: "XXXXXX"),
        KingsCupRules(deck: Deck(suit: .heart, rank: .six, icon: Images.heart), title: "Dicks", rule: "Gentlemen drink"),
        KingsCupRules(deck: Deck(suit: .spades, rank: .seven, icon: Images.spade), title: "Heaven", rule: "Put your fingers up in the air. last one drinks"),
        KingsCupRules(deck: Deck(suit: .clubs, rank: .eight, icon: Images.club), title: "Mate", rule: "Find a buddy, who drinks every time you drink throughout the game"),
        KingsCupRules(deck: Deck(suit: .diamond, rank: .nine, icon: Images.diamond), title: "Rhyme", rule: "Pick a word, others must rhyme it or drink"),
        KingsCupRules(deck: Deck(suit: .heart, rank: .ten, icon: Images.heart), title: "Categories", rule: "Pick a category, others need to say things in the category, or drink"),
        KingsCupRules(deck: Deck(suit: .clubs, rank: .jack, icon: Images.club), title: "Rule", rule: "Make a rule that lasts the entire game"),
        KingsCupRules(deck: Deck(suit: .spades, rank: .queen, icon: Images.spade), title: "Question Master", rule: "Ask questions. Who answers, drinks. Who responses with a questions, makes you drink. Effect lasts until a new queen is drawn."),
        KingsCupRules(deck: Deck(suit: .diamond, rank: .king, icon: Images.diamond), title: "Pour to the cup", rule: "The person, who picks the last king, drinks the mix. Game over!")
    ]
    
    let pyramid: [PyramidRule] = [
        PyramidRule(image: Images.Nr.one, title: "Objective", rule: "The general target is to reach to the top of the pyramid, avoiding face cards (jack, queen, king, ace)"),
        PyramidRule(image: Images.Nr.two, title: "Start", rule: "Pick a card from the first row"),
        PyramidRule(image: Images.Nr.three, title: "Game", rule: "If the card is a number card (1 - 10), then move on to the next row"),
        PyramidRule(image: Images.Nr.four, title: "Continue", rule: "Advance by successfully picking a number card from each consecutive row"),
        PyramidRule(image: Images.Nr.five, title: "Penalty", rule: "If the card you picked is a face card, you will go back to the beginning. You will also have to take sips of your drink, depending on what row you were on. If your run ended in the first row, take 1 sip. On second row, take 2. 3rd row = 3, 4th row = 4, and 5th = 5"),
        PyramidRule(image: Images.Nr.six, title: "Go again", rule: "The cards you have previously picked, will be put back into the deck, and will be swapped with brand new cards"),
        PyramidRule(image: Images.Nr.seven, title: "Next Player", rule: "If you reach to the top of the pyramid, it is the next player's turn. You can take a break"),
        PyramidRule(image: Images.Nr.eight, title: "Winner", rule: "There are no winners, only a biggest loser, aka the most drunk")
    ]
    
    let roulette: [RouletteRule] = [
        RouletteRule(image: Images.Nr.one, title: "Objective", rule: "The general target is to make a correct bet on a roulette table"),
        RouletteRule(image: Images.Nr.two, title: "Place a bet", rule: "Choose a bet you want to place"),
        RouletteRule(image: Images.Nr.three, title: "Play", rule: "Spin the roulette table"),
        RouletteRule(image: Images.Nr.four, title: "Penalty", rule: "If you lose your bet, you take a drink"),
        RouletteRule(image: Images.Nr.five, title: "Win 1", rule: "If your bet was placed on the bottom row (bets with 1/2 odds), you can give out 2 drinks"),
        RouletteRule(image: Images.Nr.six, title: "Win 2", rule: "If your bet was placed on the top row (bets with 1/3 odds), you can give out 3 drinks")
    ]
    
    let wheel: [WheelRule] = [
        WheelRule(image: Images.Nr.one, title: "Objective", rule: "The general idea objective is to pick punishments of your choice and take turns on spinning the wheel"),
        WheelRule(image: Images.Nr.two, title: "Components", rule: "Pick up to 10 punishments, that will be represented on the wheel"),
        WheelRule(image: Images.Nr.three, title: "Spin the wheel", rule: "Spin the wheel and see what punishment you need to be doing"),
        WheelRule(image: Images.Nr.four, title: "Go around", rule: "Take turns and play as long as you want")
    ]
    
    let spinBottle: [SpinBottleRule] = [
        SpinBottleRule(image: Images.Nr.one, title: "Objective", rule: "The general goal is to spin the bottle and determine who has to do a punishment"),
        SpinBottleRule(image: Images.Nr.two, title: "Setup", rule: "Agree amongst the playes what is the rule/punishment when the bottle lands on a person"),
        SpinBottleRule(image: Images.Nr.three, title: "Play", rule: "Spin the bottle by tapping on the bottle on the screen"),
        SpinBottleRule(image: Images.Nr.four, title: "Outcome", rule: "Execute the rule/punishemnt on the person, towards who the bottle is pointing")
    ]
    
    let chooser: [ChooserRule] = [
        ChooserRule(image: Images.Nr.one, title: "Objective", rule: "The general objective is to find a loser who has to drink"),
        ChooserRule(image: Images.Nr.two, title: "Setup", rule: "Each player touches and holds one finger on the screen"),
        ChooserRule(image: Images.Nr.three, title: "Game", rule: "When everyone is locked in, the loser's finger will be the only one lit up")
    ]
    let neverHaveIEver = ""
    let truthOrDare = ""
}
