import Foundation

struct TriviaQuestion: Identifiable, Codable {
    var id = UUID()
    let question: String
    let answer: String
    let answerDescription: String
    let a: String
    let b: String
    let c: String
    let d: String
    
    enum CodingKeys: String, CodingKey {
        case question = "Question"
        case answer = "Answer"
        case a = "A"
        case b = "B"
        case c = "C"
        case d = "D"
        case answerDescription = "Description"
    }
}
