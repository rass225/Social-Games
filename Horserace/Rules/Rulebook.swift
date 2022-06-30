import Foundation
import SwiftUI

struct RuleBook {
    
    let horseRace: [HorseRaceRule] = [
        HorseRaceRule(image: Images.Nr.one, title: "Objective", rule: "The general idea is to pick a horse that you think would win the race."),
        HorseRaceRule(image: Images.Nr.two, title: "Pick a Suit", rule: "Pick a suit that you would think would come up on top."),
        HorseRaceRule(image: Images.Nr.three, title: "Bet", rule: "Place your bet and cheer your horse on."),
        HorseRaceRule(image: Images.Nr.four, title: "Setup", rule: "4 aces, representing each suit, will be lined up to start a race."),
        HorseRaceRule(image: Images.Nr.five, title: "Start", rule: "A card will be drawn from the deck. An ace, that has a matching suit with that card, will be moved forward to the next base."),
        HorseRaceRule(image: Images.Nr.six, title: "Game", rule: "One by one cards will be drawn from the deck. Each time an appropriate ace will be moved forward to the next base."),
        HorseRaceRule(image: Images.Nr.seven, title: "Penalty", rule: "If all four aces have reached certain base, a penalty card will be flipped. Depending on the suit of the penalty card, corresponding ace will be moved back by one base."),
        HorseRaceRule(image: Images.Nr.eight, title: "Game over", rule: "The game is over, when the first ace reaches the finish line."),
        HorseRaceRule(image: Images.Nr.nine, title: "Winner", rule: "The players who's horce(suit) won, can give out double of their own bet.")
    ]
    
    let pyramid: [PyramidRule] = [
        PyramidRule(image: Images.Nr.one, title: "Objective", rule: "The general target is to reach to the top of the pyramid, avoiding face cards (jack, queen, king, ace)."),
        PyramidRule(image: Images.Nr.two, title: "Start", rule: "Pick a card from the first row."),
        PyramidRule(image: Images.Nr.three, title: "Game", rule: "If the card is a number card (1 - 10), then move on to the next row."),
        PyramidRule(image: Images.Nr.four, title: "Continue", rule: "Advance by successfully picking a number card from each consecutive row."),
        PyramidRule(image: Images.Nr.five, title: "Penalty", rule: "If the card you picked is a face card, you will go back to the beginning. You will also get penalty points, depending on what row you were on. If your run ended in the first row, take 1 penalty point. On second row, 2. 3rd row = 3, 4th row = 4, and 5th = 5."),
        PyramidRule(image: Images.Nr.six, title: "Go again", rule: "The cards you have previously picked, will be put back into the deck, and will be swapped with brand new cards."),
        PyramidRule(image: Images.Nr.seven, title: "Next Player", rule: "If you reach to the top of the pyramid, it is the next player's turn. You can take a break."),
        PyramidRule(image: Images.Nr.eight, title: "Winner", rule: "There are no winners, only a biggest loser")
    ]
    
    let roulette: [RouletteRule] = [
        RouletteRule(image: Images.Nr.one, title: "Objective", rule: "The general target is to make a correct bet on a roulette table."),
        RouletteRule(image: Images.Nr.two, title: "Place a bet", rule: "Choose a bet you want to place."),
        RouletteRule(image: Images.Nr.three, title: "Play", rule: "Spin the roulette table."),
        RouletteRule(image: Images.Nr.four, title: "Penalty", rule: "If you lose your bet, you need to do a punishment."),
        RouletteRule(image: Images.Nr.five, title: "Win 1", rule: "If your bet was placed on the bottom row (bets with 1/2 odds), you can give out 2 punishments."),
        RouletteRule(image: Images.Nr.six, title: "Win 2", rule: "If your bet was placed on the top row (bets with 1/3 odds), you can give out 3 punishments.")
    ]
    
    let wheel: [WheelRule] = [
        WheelRule(image: Images.Nr.one, title: "Objective", rule: "The general idea objective is to pick punishments of your choice and take turns on spinning the wheel."),
        WheelRule(image: Images.Nr.two, title: "Components", rule: "Pick up to 10 punishments, that will be represented on the wheel."),
        WheelRule(image: Images.Nr.three, title: "Spin the wheel", rule: "Spin the wheel and see what punishment you need to be doing."),
        WheelRule(image: Images.Nr.four, title: "Go around", rule: "Take turns and play as long as you want.")
    ]
    
    let spinBottle: [SpinBottleRule] = [
        SpinBottleRule(image: Images.Nr.one, title: "Objective", rule: "The general goal is to spin the bottle and determine who has to do a punishment."),
        SpinBottleRule(image: Images.Nr.two, title: "Setup", rule: "Agree amongst the playes what is the rule/punishment when the bottle lands on a person."),
        SpinBottleRule(image: Images.Nr.three, title: "Play", rule: "Spin the bottle by tapping on the bottle on the screen."),
        SpinBottleRule(image: Images.Nr.four, title: "Outcome", rule: "Execute the rule/punishemnt on the person, towards who the bottle is pointing.")
    ]
    
    let chooser: [ChooserRule] = [
        ChooserRule(image: Images.Nr.one, title: "Objective", rule: "The general objective is to find a loser."),
        ChooserRule(image: Images.Nr.two, title: "Setup", rule: "Each player touches and holds one finger on the screen."),
        ChooserRule(image: Images.Nr.three, title: "Game", rule: "When everyone is locked in, the loser's finger will be the only one lit up.")
    ]
    
    let truthOrDare: [TruthOrDareRule] = [
        TruthOrDareRule(image: Images.Nr.one, title: "Objective", rule: "The general idea is to make a decisive decision - truth or dare?"),
        TruthOrDareRule(image: Images.Nr.two, title: "Setup", rule: "Sit down with your friends and start taking turns."),
        TruthOrDareRule(image: Images.Nr.three, title: "Choice", rule: "Make a choice between telling a truth or doing an dare activity."),
        TruthOrDareRule(image: Images.Nr.four, title: "Truth", rule: "Answer the question turthfully or do a punishment."),
        TruthOrDareRule(image: Images.Nr.five, title: "Dare", rule: "Do the dare activity or do a punishment."),
        TruthOrDareRule(image: Images.Nr.six, title: "Play", rule: "Play however long you choose to. There is no concrete ending to this game.")
    ]
    
    let neverHaveIEver: [NeverHaveIEverRule] = [
        NeverHaveIEverRule(image: Images.Nr.one, title: "Objective", rule: "The general idea is to determine whether you have done an action in your life or not"),
        NeverHaveIEverRule(image: Images.Nr.two, title: "Setup", rule: "Sit down with your friends and start taking turns"),
        NeverHaveIEverRule(image: Images.Nr.three, title: "Game", rule: "Read a statement, written on the screen, out loud. If you haven't done this activity/action, you pass the turn to the next player. If you have, however, you need to do punishment"),
        NeverHaveIEverRule(image: Images.Nr.four, title: "Play", rule: "Play however long you choose to. There is no concrete ending to this game.")
    ]
    
    let higherLower: [HigherLowerRule] = [
        HigherLowerRule(image: Images.Nr.one, title: "Objective", rule: "The general idea of the game is to make a right decision by picking higher or lower"),
        HigherLowerRule(image: Images.Nr.two, title: "Setup", rule: "Choose the number of players who play, and determine a penalty, if someone were to make an inaccurate prediction"),
        HigherLowerRule(image: Images.Nr.three, title: "Game", rule: "Start taking turns. The left card is the card you play against. Predict whether the next card will be lower or higher of the card on the field."),
        HigherLowerRule(image: Images.Nr.four, title: "Streak", rule: "Every time a player makes an accurate prediction, the streak is incremented."),
        HigherLowerRule(image: Images.Nr.five, title: "Penalty", rule: "If a player makes an inaccurate prediction, they will receive as many penalty points as the streak count is at that moment")
    ]
    
    let whosMostLikely: [WhosMostLikelyRule] = [
        WhosMostLikelyRule(image: Images.Nr.one, title: "Objective", rule: "The general objective of the game is to determine of whom the card is talking about"),
        WhosMostLikelyRule(image: Images.Nr.two, title: "Setup", rule: "Sit down with your friends and start taking turns"),
        WhosMostLikelyRule(image: Images.Nr.three, title: "Game", rule: "The person, who's turn it is, reads out loud the text on the card. Everyone will nominate someone, who they think matches that descrption the best"),
        WhosMostLikelyRule(image: Images.Nr.four, title: "Play", rule: "Play however long you choose to. There is no concrete ending to this game.")
    ]
}
