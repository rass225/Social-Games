import Foundation

struct NeverHaveIEverQuestion: Codable, Hashable {
    let question: String
    
    enum CodingKeys: String, CodingKey {
        case question = "Question"
    }
}
