import SwiftUI
import Foundation
import Combine

struct JSONClient {
    
    enum Client: String {
        case TruthTierOne
        case TruthTierTwo
        case TruthTierThree
        case DareTierOne
        case DareTierTwo
        case DareTierThree
        case NeverHaveIEverTierOne
        case NeverHaveIEverTierTwo
        case NeverHaveIEverTierThree
        case WhosMostLikelyTierOne
        case WhosMostLikelyTierTwo
        case TriviaGeography
        case TriviaSports
        case TriviaMovies
        case TriviaHistory
        case TriviaScience
        case TriviaMusic
    }
    
    func fetch<T: Codable>(client: Client, completion: @escaping  (Result<T, Error>) -> ()) {
        
        if let url = Bundle.main.url(forResource: client.rawValue, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                completion(.success(jsonData))
            } catch let error{
                completion(.failure(error))
            }
        }
    }
    
    func fetch<T: Codable>(string: String, completion: @escaping  (Result<T, Error>) -> ()) {
        
        if let url = Bundle.main.url(forResource: string, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                completion(.success(jsonData))
            } catch let error{
                completion(.failure(error))
            }
        }
    }
}
