import Foundation
import SwiftUI

struct Truth: Codable, Hashable {
    let question: String
    
    enum CodingKeys: String, CodingKey {
        case question = "Question"
    }
}


struct Dare: Codable, Hashable {
    let question: String
    
    enum CodingKeys: String, CodingKey {
        case question = "Question"
    }
}
