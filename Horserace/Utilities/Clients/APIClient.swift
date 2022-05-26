import Foundation
import SwiftUI
import Combine

struct APIClient {
    func fetch<T: Codable>(url: String, completion: @escaping  (Result<T, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(response))
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
}
