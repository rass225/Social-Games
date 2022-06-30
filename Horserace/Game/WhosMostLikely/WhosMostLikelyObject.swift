import Foundation

struct WhosMostLikelyQuestion: Codable, Hashable {
    let question: String
    
    enum CodingKeys: String, CodingKey {
        case question = "Question"
    }
}
